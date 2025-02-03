{ config, ... }:
let
  git = config.programs.git;
in
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = git.userName;
      user.email = git.userEmail;
    };
  };
}
