{pkgs, ...}: {
  gtk.enable = true;
  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    chromium.enable = true;
    obs-studio.enable = true;
    htop.enable = true;
    jq.enable = true;
  };
  home.packages = with pkgs; [
    fd
    eza
    tldr
    mission-center
    ncdu
    tor-browser
    peazip
    gnome.pomodoro
    meld
    zoom-us
    gnumake
    dig
    gnome.gnome-clocks
    mtr
  ];
}
