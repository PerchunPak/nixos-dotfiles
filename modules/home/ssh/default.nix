{ lib, config, ... }:
{
  age.secrets.ssh-config.file = lib.my.toSecretFile "ssh-config";
  age.secrets.ssh-config.path = ".ssh/real_config";

  my.persistence.directories = [ ".ssh" ];

  programs.ssh = {
    enable = true;
    includes = [ (lib.removePrefix ".ssh/" config.age.secrets.ssh-config.path) ];
  };
}
