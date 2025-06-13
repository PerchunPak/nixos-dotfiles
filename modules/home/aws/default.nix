{
  lib,
  config,
  pkgs,
  ...
}:
{
  age.secrets.aws-default.file = lib.my.toSecretFile "aws-default";
  age.secrets.aws-perchun.file = lib.my.toSecretFile "aws-perchun";
  age.secrets.aws-work-cmd.file = lib.my.toSecretFile "aws-work-cmd";
  age.secrets.aws-start-db.file = lib.my.toSecretFile "aws-start-db";
  age.secrets.aws-stop-db.file = lib.my.toSecretFile "aws-stop-db";

  programs.awscli = {
    enable = true;
    credentials = {
      default = {
        "credential_process" = "bash -c 'cat ${config.age.secrets.aws-default.path}'";
      };
      perchun = {
        "credential_process" = "bash -c 'cat ${config.age.secrets.aws-perchun.path}'";
      };
    };
    settings = {
      "profile default".region = "eu-central-1";
      "profile perchun".region = "eu-central-1";
    };
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "aws-work" ''
      fish ${config.age.secrets.aws-work-cmd.path}
    '')
    (writeShellScriptBin "work-db" ''
      bash ${config.age.secrets.aws-start-db.path}
    '')
    (writeShellScriptBin "work-db-stop" ''
      bash ${config.age.secrets.aws-stop-db.path}
    '')

    ssm-session-manager-plugin
  ];
}
