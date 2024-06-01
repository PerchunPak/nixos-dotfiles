{ pkgs, ... }:
{
  programs.bun.enable = true;

  home.packages = with pkgs; [
    nodejs
    corepack
  ];

  my.persistence.directories = [ ".local/share/pnpm" ];
}
