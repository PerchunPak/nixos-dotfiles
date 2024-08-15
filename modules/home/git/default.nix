{
  programs.git = {
    enable = true;
    userName = "PerchunPak";
    userEmail = "git@perchun.it";
    signing = {
      key = "313F67D1EAB770F9";
      signByDefault = true;
    };
    delta.enable = true; # syntax highlighting in diff
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      push.autoSetupRemote = true;
      pull.rebase = true;
      url = {
        "ssh://git@github.com/" = {
          insteadOf = [ "https://github.com/" ];
        };
      };
    };
  };
}
