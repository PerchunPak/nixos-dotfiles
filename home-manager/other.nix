{pkgs, ...}: {
  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    chromium.enable = true;
    obs-studio.enable = true;
    htop.enable = true;
    lazygit.enable = true;
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
  ];

  home.sessionVariables = {
    # Run Electron apps natively on Wayland
    # See https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    NIXOS_OZONE_WL = "1";
  };
}
