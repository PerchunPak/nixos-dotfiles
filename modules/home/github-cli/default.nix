{channels, ...}: {
  programs.gh = {
    enable = true;
    extensions = [channels.unstable.gh-copilot];
    settings = {
      git_protool = "ssh";
    };
  };

  my.impermanence.files = [".config/gh/hosts.yml"];
}
