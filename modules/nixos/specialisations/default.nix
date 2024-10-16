{ lib, ... }:
{
  specialisation = {
    nogui.configuration = {
      my = {
        gui.enable = lib.mkForce false;
        hyprland.enable = lib.mkForce false;
        gaming.steam.enable = lib.mkForce false;
        flatpak.enable = lib.mkForce false;
      };
    };
  };
}
