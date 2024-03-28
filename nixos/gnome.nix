{
  pkgs,
  lib,
  ...
}: {
  config = {
    services.xserver = {
      enable = lib.mkDefault true;
      displayManager = {
        gdm.enable = true;
        defaultSession = "gnome";
      };
      desktopManager.gnome.enable = true;
    };

    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [pkgs.gnome-tour];
    environment.systemPackages = with pkgs; [
      gnome-text-editor
      gnome.gnome-calculator
      loupe # image viewer
      gnome.nautilus # file manager
      snapshot # screenshot utility
      gnome.totem # video player
    ];

    programs.dconf.enable = true;
  };
}
