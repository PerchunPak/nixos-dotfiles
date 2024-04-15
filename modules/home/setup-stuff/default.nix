{
  lib,
  config,
  ...
}: let
  cfg = config.my.setup-stuff;
  enabledServices = lib.attrsets.filterAttrs (n: v: v.enable) cfg;
in {
  options = {
    my.setup-stuff = lib.mkOption {
      description = "Attribute set of simple objects to create systemd service for setting up some stuff.";
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable = lib.my.mkEnableByDefaultOption "this service";
          command = lib.mkOption {type = lib.types.str;};
        };
      });
    };
  };

  config.systemd.user.services =
    lib.mkIf
    (enabledServices != [])
    (
      lib.concatMapAttrs (
        name: {command, ...}: {
          "setup-${name}" = {
            Unit = {
              After = ["agenix.service"];
              # 3 total retries
              StartLimitIntervalSec = 0;
              StartLimitBurst = 3;
            };

            Install.WantedBy = ["default.target"];
            Service = {
              Type = "oneshot";
              RestartSec = 5;
              Restart = "on-failure";
              ExecStart = command;
            };
          };
        }
      )
      enabledServices
    );
}
