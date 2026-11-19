{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.my.openrgb;
  stateDir = "/var/lib/OpenRGB";
  json = pkgs.formats.json { };
  profileName = lib.removeSuffix ".json" (baseNameOf cfg.profile);
  customSettingsJson = json.generate "openrgb-settings.json" cfg.settings;

  power = pkgs.writeShellScript "openrgb-power" ''
    set -u
    PATH=${
      lib.makeBinPath [
        pkgs.coreutils
        pkgs.gawk
        config.services.hardware.openrgb.package
      ]
    }

    config=$(mktemp -d)
    trap 'rm -rf "$config"' EXIT
    # Connects to the local server instead of detecting hardware itself.
    orgb() { timeout 20 openrgb --nodetect --config "$config" "$@"; }

    case "$1" in
      off)
        args=()
        for i in $(orgb -ld | awk '
          /^[0-9]+: / { i = $1; sub(":", "", i) }
          /^ *Type: *(DRAM|GPU|Motherboard) *$/ { print i }
        '); do
          args+=(-d "$i" -m off)
        done
        [ ''${#args[@]} -gt 0 ] && orgb "''${args[@]}"
        ;;
      on)
        orgb -p ${profileName}
        ;;
    esac
  '';
in
{
  options = {
    my.openrgb = {
      enable = lib.mkEnableOption "OpenRGB";
      configFile = lib.mkOption {
        description = "OpenRGB Configuration.json file (e.g. manually resized zones).";
        type = lib.types.path;
      };
      profile = lib.mkOption {
        description = "OpenRGB profile JSON file, loaded on startup.";
        type = lib.types.path;
      };
      settings = lib.mkOption {
        description = "Settings merged into the service's OpenRGB.json on every start.";
        type = json.type;
        default = { };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };

    my.openrgb.settings = {
      ProfileManager = {
        service_startup_profile = {
          enabled = true;
          name = profileName;
        };
        open_profile = {
          enabled = true;
          name = profileName;
        };
      };
    };

    systemd.services.openrgb.preStart = ''
      install -Dm644 ${cfg.profile} ${stateDir}/profiles/${profileName}.json
      install -Dm644 ${cfg.configFile} ${stateDir}/Configuration.json

      config=${stateDir}/OpenRGB.json
      [ -s "$config" ] || echo '{}' > "$config"
      ${lib.getExe pkgs.jq} -s '.[0] * .[1]' "$config" ${customSettingsJson} > "$config.tmp"
      mv "$config.tmp" "$config"
    '';

    environment.etc."systemd/system-sleep/openrgb".source =
      pkgs.writeShellScript "openrgb-sleep-hook" ''
        case "$1" in
          pre) ${power} off && ${lib.getExe' pkgs.coreutils "sleep"} 0.1 ;;
          post) exec ${power} on ;;
        esac
      '';

    systemd.services.openrgb-off-on-shutdown = {
      description = "Turn off OpenRGB lights on shutdown";
      wants = [ "openrgb.service" ];
      after = [ "openrgb.service" ];
      before = [ "systemd-user-sessions.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "${power} off";
      };
    };
  };
}
