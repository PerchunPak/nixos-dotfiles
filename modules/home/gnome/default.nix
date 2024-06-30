{ pkgs, ... }:
{
  imports = [
    ./extensions.nix
    ./settings.nix
    ./mimeapps.nix
    ./exclude-desktop-entries.nix
  ];

  home.file = {
    # alert sound
    ".local/share/sounds/__custom/bell-terminal.ogg".source = "${pkgs.gnome.gnome-control-center}/share/sounds/gnome/default/alerts/hum.ogg";
    ".local/share/sounds/__custom/bell-window-system.ogg".source = "${pkgs.gnome.gnome-control-center}/share/sounds/gnome/default/alerts/hum.ogg";

    ".local/share/backgrounds/yae_miko.png".source = builtins.fetchurl {
      url = "https://w.wallhaven.cc/full/we/wallhaven-werdv6.png";
      sha256 = "1k6f1i22ynmz4bz6wgb9kvz8vfkiz1hc3z2cbvfl3va8jh8aslr4";
    };
  };

  my.persistence = {
    directories = [ ".local/share/keyrings" ];
    files = [ ".config/monitors.xml" ];
  };

  home.sessionVariables = {
    # Run Electron apps natively on Wayland
    # See https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    NIXOS_OZONE_WL = "1";
  };
}
