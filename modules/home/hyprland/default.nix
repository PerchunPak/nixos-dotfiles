{
  inputs,
  nixosConfig,
  pkgs,
  lib,
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
        (final: prev: {
          hyprtoolkit = prev.hyprtoolkit.overrideAttrs {
            version = "0.5.4";
            src = final.fetchFromGitHub {
              owner = "hyprwm";
              repo = "hyprtoolkit";
              tag = "v0.5.4";
              hash = "sha256-gJSBj4Pd4e9nERAKo/qiHqDMpS2hBfyOI0uGCbbiML4=";
            };
          };
        })
      ];
    };
in
{
  imports = [
    ./settings.nix
  ];

  config = lib.mkIf nixosConfig.my.gui.enable {
    catppuccin.hyprland.enable = false;
    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprlandPackages.hyprland;
      portalPackage = hyprlandPackages.xdg-desktop-portal-hyprland;
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
