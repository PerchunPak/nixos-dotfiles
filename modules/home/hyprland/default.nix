{
  nixosConfig,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./settings.nix
  ];

  config = lib.mkIf nixosConfig.my.gui.enable {
    catppuccin.hyprland.enable = false;
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      configType = "lua";
    };

    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];

    programs = {
      hyprlock.enable = true;
      wlogout.enable = true;
    };

    services = {
      hypridle.enable = true;
      hyprpolkitagent.enable = true;
    };

    home.packages = with pkgs; [
      hyprcursor
      swaybg
    ];
  };
}
