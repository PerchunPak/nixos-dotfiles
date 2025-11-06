{ pkgs, ... }:
{
  home.packages = [ pkgs.legcord ];

  my.persistence.directories = [ ".config/legcord" ];
}
