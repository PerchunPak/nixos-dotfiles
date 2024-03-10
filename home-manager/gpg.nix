{
  pkgs,
  config,
  ...
}: {
  programs.gpg.enable = true;

  age.secrets.gpg-key.file = ../secrets/gpg-key.age;
  setup-secret.import-gpg-key = {
    enable = true;
    command = "${pkgs.gnupg}/bin/gpg --batch --import ${config.age.secrets.gpg-key.path}";
  };
}
