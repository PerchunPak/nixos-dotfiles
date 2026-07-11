{ pkgs, ... }:
{
  programs.codex.enable = true;

  home.packages = [ pkgs.t3code ];

  my.persistence.directories = [
    ".codex"
    ".t3"
  ];
}
