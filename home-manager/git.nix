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
      url = {
        "ssh://git@github.com/" = { insteadOf = [ "https://github.com/" ]; };
      };
    };
  };
}
