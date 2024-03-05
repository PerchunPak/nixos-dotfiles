{
  pkgs,
  config,
  ...
}: {
  programs.gpg.enable = true;

  age.secrets.gpg-key.file = ../secrets/gpg-key.age;
  systemd.user.services.import-gpg-key = {
    Unit = {
      Description = "Import GPG private key";
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
        path = replace config.age.secrets.gpg-key.path;
      in "${pkgs.gnupg}/bin/gpg --batch --import ${path}";
    };
  };
}
