{
  programs.git = {
    enable = true;
    userName = "PerchunPak";
    userEmail = "git@perchun.it";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      push.autoSetupRemote = true;
      pull.rebase = true;
      signing = {
        key = "313F67D1EAB770F9";
        signByDefault = true;
      };
      url = {
        "ssh://git@github.com/" = {insteadOf = ["https://github.com/"];};
      };
    };
  };
}
