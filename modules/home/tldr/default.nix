{ pkgs, ... }:
{
  services.tldr-update = {
    enable = true;
    package = pkgs.tealdeer;
  };

  my.persistence.directories = [ ".cache/tealdeer" ];
}
