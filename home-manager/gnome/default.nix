{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./settings.nix
    ./mimeapps.nix
  ];

  # alert sound
  home.file.".local/share/sounds/__custom/bell-terminal.ogg".source = "${pkgs.gnome.gnome-control-center}/share/sounds/gnome/default/alerts/hum.ogg";
  home.file.".local/share/sounds/__custom/bell-window-system.ogg".source = "${pkgs.gnome.gnome-control-center}/share/sounds/gnome/default/alerts/hum.ogg";
}
