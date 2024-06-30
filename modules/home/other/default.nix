{ pkgs, ... }:
{
  gtk.enable = true;

  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    chromium.enable = true;
    obs-studio.enable = true;
    htop.enable = true;
    jq.enable = true;
    ranger.enable = true;
  };

  home.packages = with pkgs; [
    fd
    eza
    tldr
    mission-center
    ncdu
    tor-browser
    stable.peazip # https://github.com/NixOS/nixpkgs/issues/305546
    gnome.pomodoro
    meld
    zoom-us
    gnumake
    dig
    gnome.gnome-clocks
    mtr
    mpv
    onefetch
    zip
    unzip
    hexyl
    bintools
    pavucontrol
    baobab # gnome disk usage analyzer
  ];
}
