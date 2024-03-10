{
  lib,
  config,
  ...
}: {
  age.secrets.ssh-config.file = ../secrets/ssh-config.age;
  age.secrets.ssh-config.path = ".ssh/real_config";

  programs.ssh = {
    enable = true;
    includes = [(lib.removePrefix ".ssh/" config.age.secrets.ssh-config.path)];
  };
}
