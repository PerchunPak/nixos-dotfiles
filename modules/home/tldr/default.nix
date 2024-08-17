{ pkgs, ... }:
{
  home.packages = with pkgs; [ tlrc ];

  my.persistence.directories = [ ".cache/tlrc" ];
}
