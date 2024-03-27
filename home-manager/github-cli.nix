{pkgs, ...}: {
  programs.gh = {
    enable = true;
    extensions = [pkgs.unstable.gh-copilot];
    settings = {
      git_protool = "ssh";
    };
  };

  home.persistence."/persist/home".files = [".config/gh/hosts.yml"];
}
