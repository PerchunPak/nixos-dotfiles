{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./settings.nix
    ./mimeapps.nix
    ./exclude-desktop-entries.nix
  ];

  # alert sound
  home.file.".local/share/sounds/__custom/bell-terminal.ogg".source = "${pkgs.gnome.gnome-control-center}/share/sounds/gnome/default/alerts/hum.ogg";
  home.file.".local/share/sounds/__custom/bell-window-system.ogg".source = "${pkgs.gnome.gnome-control-center}/share/sounds/gnome/default/alerts/hum.ogg";

  my.persistence = {
    directories = [".local/share/keyrings"];
    files = [".config/monitors.xml"];
  };

  home.sessionVariables = {
    # Run Electron apps natively on Wayland
    # See https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    NIXOS_OZONE_WL = "1";
  };
}
