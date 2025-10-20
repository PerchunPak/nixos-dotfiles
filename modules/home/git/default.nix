{ pkgs, nixosConfig, ... }:
{
  home.packages = with pkgs; [
    git-extras
    git-revise
  ];

  programs.git = {
    enable = true;
    signing = {
      key = "313F67D1EAB770F9";
      signByDefault = true;
    };
    maintenance = {
      enable = !nixosConfig.my.economInternetTraffic;
      repositories = [ "/home/perchun/dev/nixpkgs/review" ];
    };
    settings = {
      user = {
        name = "PerchunPak";
        email = "git@perchun.it";
      };

      init.defaultBranch = "main";
      credential.helper = "store";
      push.autoSetupRemote = true;
      pull.rebase = true;
      branch.sort = "-committerdate";
      url = {
        "ssh://git@github.com/" = {
          insteadOf = [ "https://github.com/" ];
        };
        "ssh://git@gitlab.com/" = {
          insteadOf = [ "https://gitlab.com/" ];
        };
      };
      tag.gpgSign = false;

      git-extras = {
        get.clone-path = "~/dev";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
