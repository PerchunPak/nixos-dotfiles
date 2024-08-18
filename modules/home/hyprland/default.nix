{
  nixosConfig,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./settings.nix
    ./other-settings.nix
  ];

  config = lib.mkIf nixosConfig.my.hyprland.enable {
    wayland.windowManager.hyprland.enable = true;

    programs = {
      waybar.enable = true;
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
      };
      hyprlock.enable = true;
      wlogout.enable = true;
    };

    services = {
      swaync.enable = true;
      hypridle.enable = true;
    };

    home.packages = with pkgs; [
      hyprshot
      swaybg
      networkmanagerapplet
    ];
  };
}
