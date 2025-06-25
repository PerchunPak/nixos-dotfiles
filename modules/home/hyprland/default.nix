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
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
    };

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
      hyprshot
      swaybg
    ];
  };
}
