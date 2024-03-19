{pkgs, ...}: {
  programs.gh = {
    enable = true;
    extensions = [pkgs.my.gh-copilot];
    settings = {
      git_protool = "ssh";
    };
  };

  home.persistence."/persist/home".files = [".config/gh/hosts.yml"];
}
