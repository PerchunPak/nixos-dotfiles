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
  };
}
