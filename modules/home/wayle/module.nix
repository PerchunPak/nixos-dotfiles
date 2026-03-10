{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.wayle;
  tomlFormat = pkgs.formats.toml { };
in
{
  meta.maintainers = [ lib.maintainers.PerchunPak ];

  options.programs.wayle = {
    enable = lib.mkEnableOption "wayle shell";

    package = lib.mkPackageOption pkgs "wayle" { };

    settings = lib.mkOption {
      type = tomlFormat.type;
      default = { };
      example = lib.literalExpression ''
        styling = {
          theme-provider = "wayle";

          palette = {
            bg = "#16161e";
            fg = "#c0caf5";
            primary = "#7aa2f7";
          };
        };

        bar = {
          scale = 1;
          location = "top";
          rounding = "sm";

          layout = {
            monitor = "*";
            left = ["clock"];
            center = ["media"];
            right = ["battery"];
          };
        };

        modules.clock = {
          format = "%H:%M";
          icon-show = true;
          label-show = true;
        };
      '';
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/wayle/config.toml`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions =
      let
        notificationDaemons = [
          "swaync"
          "dunst"
          "mako"
        ];
      in
      map (name: {
        assertion = !config.services.${name}.enable;
        message = ''
          Only one notification daemon can be enabled at once. You have enabled
          ${name} and wayle.
        '';
      }) notificationDaemons;

    home.packages = [ cfg.package ];

    xdg.configFile.wayle = lib.mkIf (cfg.settings != { }) {
      target = "wayle/config.toml";
      source = tomlFormat.generate "wayle-config" cfg.settings;
    };

    systemd.user.services.wayle = {
      Unit = {
        Description = "Wayland Elements - A compositor agnostic shell with extensive customization";
        Documentation = "https://github.com/Jas-SinghFSU/wayle";
        PartOf = [ config.wayland.systemd.target ];
        After = [ config.wayland.systemd.target ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        ExecStart = "${cfg.package}/bin/wayle-shell";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "on-failure";
        KillMode = "mixed";
      };

      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };
    };
  };
}
