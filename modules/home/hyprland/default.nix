{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./settings.nix
  ];

  catppuccin.hyprland.enable = false;
  wayland.windowManager.hyprland = {
    enable = config.my.gui.enable;
    systemd.enable = false;
    configType = "lua";
  };

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk
  ];

  programs = {
    hyprlock.enable = config.my.gui.enable;
    wlogout.enable = config.my.gui.enable;
  };

  services = {
    hypridle.enable = config.my.gui.enable;
    hyprpolkitagent.enable = config.my.gui.enable;
  };

  home.packages = with pkgs; [
    hyprcursor
    swaybg
  ];
}
