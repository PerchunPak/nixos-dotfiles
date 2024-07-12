{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.gnome;
  guiEnabled = config.my.gui.enable;
in
{
  options = {
    my.gnome = {
      enable = lib.my.mkEnableByDefaultOption "GNOME";

      wayland = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = {
    assertions = [
      (lib.mkIf cfg.enable {
        assertion = guiEnabled;
        message = "If you enable GNOME, you must enable gui as well";
      })
    ];

    # Workaround for crashing session on auto-login
    # see https://github.com/NixOS/nixpkgs/issues/103746
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    services = {
      displayManager.defaultSession = "gnome";
      xserver = {
        enable = cfg.enable;
        displayManager.gdm = {
          enable = cfg.enable;
          wayland = cfg.wayland && cfg.enable;
        };
        desktopManager.gnome.enable = cfg.enable;
      };
    };

    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    environment.systemPackages = with pkgs; [
      gnome-text-editor
      gnome.gnome-calculator
      loupe # image viewer
      nautilus # file manager
      snapshot # screenshot utility
      totem # video player
    ];

    programs.dconf.enable = true;
  };
}
