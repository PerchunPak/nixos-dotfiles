{ pkgs, ... }:
{
  programs.bun.enable = true;

  home.packages = with pkgs; [
    nodejs
    pnpm
  ];

  my.persistence.directories = [ ".local/share/pnpm" ];
}
