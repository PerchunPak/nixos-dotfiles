{pkgs, ...}: {
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.chromium.enable = true;
  programs.obs-studio.enable = true;
  programs.htop.enable = true;
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
