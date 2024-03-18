{
  lib,
  config,
  ...
}: let
  secret-type = lib.types.submodule {
    options = {
      enable = lib.mkEnableOption "Enable this service.";
      command = lib.mkOption {type = lib.types.str;};
    };
  };
in {
  options = {
    setup-secret = lib.mkOption {
      description = "Attribute set of simple objects to create systemd service for setting up this secret.";
      type = lib.types.attrsOf secret-type;
    };
  };

  config = {
    systemd.user.services =
      lib.concatMapAttrs (
        name: secret: {
          "setup-secret-${name}" = {
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
              Restart = "onfailure";
              ExecStart = let
                replace = builtins.replaceStrings ["$XDG_RUNTIME_DIR"] ["\${XDG_RUNTIME_DIR}"];
              in
                replace secret.command;
            };
          };
        }
      )
      (
        lib.filterAttrs
        (name: secret: secret.enable)
        config.setup-secret
      );
  };
}
