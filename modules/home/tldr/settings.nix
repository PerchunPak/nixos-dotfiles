{ pkgs, ... }:
{
  programs.tldr = {
    enable = true;
    package = pkgs.tealdeer;
  };

  my.persistence.directories = [ ".cache/tlrc" ];
}
