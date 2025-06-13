{
  lib,
  config,
  pkgs,
  ...
}:
{
  age.secrets.aws-dev.file = lib.my.toSecretFile "aws-dev";
  age.secrets.aws-perchun.file = lib.my.toSecretFile "aws-perchun";
  age.secrets.aws-work-cmd.file = lib.my.toSecretFile "aws-work-cmd";
  age.secrets.aws-start-db.file = lib.my.toSecretFile "aws-start-db";
  age.secrets.aws-stop-db.file = lib.my.toSecretFile "aws-stop-db";

  programs.awscli = {
    enable = true;
    settings = {
      "profile dev".region = "eu-central-1";
      "profile default".region = "eu-central-1";
      "profile perchun".region = "eu-central-1";
    };
  };

  # home-manager module sorts sections alphabetically, which is not what I want
  home.file.".aws/credentials".text = ''
    [dev]
    credential_process=bash -c 'cat ''${XDG_RUNTIME_DIR}/agenix/aws-dev'

    [default]
    credential_process=bash -c 'cat ''${XDG_RUNTIME_DIR}/agenix/aws-dev'

    [perchun]
    credential_process=bash -c 'cat ''${XDG_RUNTIME_DIR}/agenix/aws-perchun'
  '';

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
