{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    my.hyprland = {
      monitors = lib.mkOption {
        type =
          with lib.types;
          oneOf [
            (listOf attrs)
            attrs
          ];
        description = ''
          A list of monitors passed down to hyprland
          https://wiki.hyprland.org/Configuring/Monitors/
        '';
      };
    };
  };

  config = lib.mkIf config.my.gui.enable {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
      hyprlock.enable = true;
    };

    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal ];

    services.displayManager.defaultSession = "hyprland-uwsm";
  };
}
