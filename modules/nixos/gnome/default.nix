{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.gnome;
in
{
  options = {
    my.gnome = {
      enable = lib.my.mkEnableByDefaultOption "GNOME";
    };
  };

  config = lib.mkIf cfg.enable {
    # Workaround for crashing session on auto-login
    # see https://github.com/NixOS/nixpkgs/issues/103746
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        defaultSession = "gnome";
      };
      desktopManager.gnome.enable = true;
    };

    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    environment.systemPackages = with pkgs; [
      gnome-text-editor
      gnome.gnome-calculator
      loupe # image viewer
      gnome.nautilus # file manager
      snapshot # screenshot utility
      gnome.totem # video player
    ];

    programs.dconf.enable = true;
  };
}
