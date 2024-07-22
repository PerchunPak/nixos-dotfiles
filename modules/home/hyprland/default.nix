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
    };

    services = {
      swaync.enable = true;
    };

    home.packages = with pkgs; [
      hyprshot
      swaybg
      networkmanagerapplet
    ];
  };
}
