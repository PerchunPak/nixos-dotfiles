{ pkgs, ... }:
{
  services.tldr-update = {
    enable = true;
    package = pkgs.tealdeer;
  };

  home.packages = [ pkgs.tealdeer ];

  my.persistence.directories = [ ".cache/tealdeer" ];
}
