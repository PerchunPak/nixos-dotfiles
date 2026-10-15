{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  hyprlandPackages =
    # these nasty workarounds to fix cursor flickering are needed only until the next release
    assert pkgs.hyprland.version == "0.56.2";
    import inputs.nixpkgs {
      localSystem = pkgs.stdenv.hostPlatform.system;
      overlays = with inputs.hyprland.overlays; [
        hyprland-packages
        hyprland-extras
      ];
    };
in
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
        package = hyprlandPackages.hyprland;
        portalPackage = hyprlandPackages.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        withUWSM = true;
      };
      hyprlock.enable = true;
    };

    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal ];

    services.displayManager.defaultSession = "hyprland-uwsm";
  };
}
