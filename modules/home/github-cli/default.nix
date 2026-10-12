{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  my.persistence.directories = [ ".config/gh" ];
}
