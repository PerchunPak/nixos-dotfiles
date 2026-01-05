{ lib, ... }:
{
  age.secrets.aws-creds.file = lib.my.toSecretFile "aws-creds";

  programs.awscli = {
    enable = true;
    settings = {
      "profile default".region = "eu-central-1";
    };
  };

  # home-manager module sorts sections alphabetically, which is not what I want
  home.file.".aws/credentials".text = ''
    [default]
    credential_process=bash -c 'cat ''${XDG_RUNTIME_DIR}/agenix/aws-creds'
  '';
}
