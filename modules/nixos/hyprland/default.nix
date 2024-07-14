{ lib, config, ... }:
let
  cfg = config.my.hyprland;
  guiEnabled = config.my.gui.enable;
in
{
  options = {
    my.hyprland = {
      enable = lib.my.mkEnableByDefaultOption "Hyprland";

      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.string;
        description = ''
          A list of monitors passed down to hyprland
          https://wiki.hyprland.org/Configuring/Monitors/
        '';
      };
    };
  };

  config = lib.mkMerge [
    {
      assertions = [
        (lib.mkIf cfg.enable {
          assertion = guiEnabled;
          message = "If you enable Hyprland, you must enable gui as well";
        })
      ];
    }

    (lib.mkIf cfg.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      xdg.portal.enable = true;
      # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

      services.displayManager.defaultSession = lib.mkDefault "hyprland";
    })
  ];
}
