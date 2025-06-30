{
  lib,
  config,
  pkgs,
  ...
}:
{
  age.secrets.aws-dev.file = lib.my.toSecretFile "aws-dev";
  age.secrets.aws-perchun.file = lib.my.toSecretFile "aws-perchun";
  age.secrets.aws-work-start.file = lib.my.toSecretFile "aws-work-start";
  age.secrets.aws-work-stop.file = lib.my.toSecretFile "aws-work-stop";

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
    (writeShellScriptBin "work-start" ''
      bash ${config.age.secrets.aws-work-start.path}
    '')
    (writeShellScriptBin "work-stop" ''
      bash ${config.age.secrets.aws-work-stop.path}
    '')

    ssm-session-manager-plugin
  ];
}
