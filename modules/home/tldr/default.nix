{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.tldr;
in
{
  imports = [ ./settings.nix ];

  meta.maintainers = [ lib.maintainers.perchun ];

  options.programs.tldr = {
    enable = lib.mkEnableOption "TLDR CLI";

    package = lib.mkPackageOption pkgs "tldr" { example = "tlrc"; };

    auto-updates = {
      enable = lib.mkEnableOption "Auto updates" // {
        default = true;
      };

      period = lib.mkOption {
        type = lib.types.str;
        default = "weekly";
        description = ''
          Systemd timer period to create for scheduled {command}`tldr --update`.
        '';
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [ cfg.package ];

    })
    (lib.mkIf cfg.auto-updates.enable {
      systemd.user.services.tldr-update = {
        Unit = {
          Description = "Update tldr CLI cache";
          Documentation = "https://tldr.sh/";
        };

        Service = {
          Type = "oneshot";
          ExecStart = ''
            "${lib.getExe cfg.package}" --update
          '';
        };
      };

      systemd.user.timers.tldr-update = {
        Unit.Description = "Update tldr CLI cache";

        Timer = {
          OnCalendar = cfg.auto-updates.period;
          Persistent = true;
        };

        Install.WantedBy = [ "timers.target" ];
      };
    })
  ];
}
