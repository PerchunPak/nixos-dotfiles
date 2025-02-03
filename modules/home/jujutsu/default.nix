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

      core.fsmonitor = "watchman";
      core.watchman.register_snapshot_trigger = true;

      signing = {
        "sign-all" = true;
        key = git.signing.key;
      };
    };
  };
}
