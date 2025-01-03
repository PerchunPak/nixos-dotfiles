{
  nixosConfig,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./settings.nix
  ];

  config = lib.mkIf nixosConfig.my.hyprland.enable {
    wayland.windowManager.hyprland.enable = true;

    programs = {
      waybar.enable = true;
      hyprlock.enable = true;
      wlogout.enable = true;
    };

    services = {
      swaync.enable = true;
      hypridle.enable = true;
    };

    home.packages = with pkgs; [
      hyprcursor
      hyprshot
      swaybg
      networkmanagerapplet
    ];
  };
}
