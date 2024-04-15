{pkgs, ...}: {
  programs.gh = {
    enable = true;
    extensions = [pkgs.unstable.gh-copilot];
    settings = {
      git_protool = "ssh";
    };
  };

  my.persistence.files = [".config/gh/hosts.yml"];
}
