{ lib, ... }:
{
  specialisation = {
    nogui.configuration = {
      my.gui.enable = lib.mkForce false;
      my.gnome.enable = lib.mkForce false;
      my.hyprland.enable = lib.mkForce false;
      my.gaming.steam.enable = lib.mkForce false;
    };

    hyprland.configuration = {
      my.gnome.enable = lib.mkForce false;
      my.hyprland.enable = lib.mkForce true;
    };
  };
}
