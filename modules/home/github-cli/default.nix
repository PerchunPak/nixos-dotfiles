{pkgs, ...}: {
  programs.gh = {
    enable = true;
    extensions = [pkgs.gh-copilot];
    settings = {
      git_protool = "ssh";
    };
  };

  my.persistence.files = [".config/gh/hosts.yml"];
}
