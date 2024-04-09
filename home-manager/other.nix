{pkgs, ...}: {
  gtk.enable = true;
  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    chromium.enable = true;
    obs-studio.enable = true;
    htop.enable = true;
    lazygit.enable = true;
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
    vlc
    meld
    zoom-us
    gnumake
    dig
    pciutils # neofetch needs this to display GPU
    gnome.gnome-clocks
  ];

  home.sessionVariables = {
    # Run Electron apps natively on Wayland
    # See https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    NIXOS_OZONE_WL = "1";
  };
}
