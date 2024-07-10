{
  programs.gh = {
    enable = true;
    settings = {
      git_protool = "ssh";
    };
  };

  my.persistence.directories = [ ".config/gh" ];
}
