{
  lib,
  config,
  pkgs,
  ...
}:
{
  age.secrets.aws-dev.file = lib.my.toSecretFile "aws-dev";
  age.secrets.aws-perchun.file = lib.my.toSecretFile "aws-perchun";
  age.secrets.aws-fish.file = lib.my.toSecretFile "aws-fish";

  programs.awscli = {
    enable = true;
    credentials = {
      dev = {
        "credential_process" = "bash -c 'cat ${config.age.secrets.aws-dev.path}'";
      };
      perchun = {
        "credential_process" = "bash -c 'cat ${config.age.secrets.aws-perchun.path}'";
      };
    };
    settings = {
      "profile perchun".region = "eu-central-1";
    };
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "aws-work" ''
      fish ${config.age.secrets.aws-fish.path}
    '')

    ssm-session-manager-plugin
  ];
}
