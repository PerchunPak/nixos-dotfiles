{
  pkgs,
  lib,
  ...
}: {
  config = {
    services.xserver.enable = lib.mkDefault true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    services.gnome.core-utilities.enable = false;
    environment.systemPackages = with pkgs; [
      gnome-text-editor
      gnome.gnome-calculator
      loupe # image viewer
      gnome.nautilus # file manager
      snapshot # screenshot utility
      gnome.totem # video player
      gnome.gnome-software # gui package installer

      gnome.gnome-tweaks
    ];

    programs.dconf.enable = true;
  };
}
