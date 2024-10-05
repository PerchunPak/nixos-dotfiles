{ pkgs, ... }:
{
  # Workaround for crashing session on auto-login
  # see https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-calculator
    loupe # image viewer
    nautilus # file manager
    totem # video player
  ];
}
