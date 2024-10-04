{ pkgs, ... }:
{
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-calculator
    loupe # image viewer
    nautilus # file manager
    totem # video player
  ];
}
