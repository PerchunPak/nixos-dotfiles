{ lib, config, ... }:
{
  age.secrets.aws.file = lib.my.toSecretFile "aws";

  programs.awscli = {
    enable = true;
    credentials = {
      dev = {
        "credential_process" = "bash -c 'cat ${config.age.secrets.aws.path}'";
      };
    };
  };
}
