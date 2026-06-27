{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  my.persistence.directories = [ ".local/share/direnv" ];
}
