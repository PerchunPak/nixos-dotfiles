{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.hyprpanel;
  jsonFormat = pkgs.formats.json { };
in
{
  imports = [ ./settings.nix ];

  options.programs.hyprpanel = {
    enable = lib.mkEnableOption "HyprPanel";

    package = lib.mkPackageOption pkgs.my "hyprpanel" { };

    settings = lib.mkOption {
      type = jsonFormat.type;
      default = { };
      example = lib.literalExpression ''''; # TODO
      description = ''
        Configuration written to
        {file}`$XDG_CONFIG_HOME/hyprpanel/config.json`.

        See <https://hyprpanel.com/configuration/settings.html#home-manager-module>
        for the full list of options.
      '';
    };

    systemd.enable = (lib.mkEnableOption "HyprPanel systemd integration") // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.hyprpanel.settings = lib.mkIf config.services.hypridle.enable {
      # fix hypridle module if user uses systemd service
      bar.customModules.hypridle = {
        startCommand = lib.mkDefault "systemctl --user start hypridle.service";
        stopCommand = lib.mkDefault "systemctl --user stop hypridle.service";
        isActiveCommand = lib.mkDefault "systemctl --user status hypridle.service | grep -q 'Active: active (running)' && echo 'yes' || echo 'no'";
      };
    };

    xdg.configFile.hyprpanel = lib.mkIf (cfg.settings != { }) {
      target = "hyprpanel/config.json";
      source = jsonFormat.generate "hyprpanel-config" cfg.settings;
      # hyprpanel replaces it with the same file, but without new line in the end
      force = true;
    };

    systemd.user.services.hyprpanel = lib.mkIf cfg.systemd.enable {
      Unit = {
        Description = "Bar/Panel for Hyprland with extensive customizability";
        Documentation = "https://hyprpanel.com/getting_started/hyprpanel.html";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
        X-Restart-Triggers = lib.optional (cfg.settings != { }) "${config.xdg.configFile.hyprpanel.source}";
      };

      Service = {
        ExecStart = "${cfg.package}/bin/hyprpanel";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "on-failure";
        KillMode = "mixed";
      };

      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
  };
}
