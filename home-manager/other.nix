{pkgs, ...}: {
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.chromium.enable = true;
  programs.obs-studio.enable = true;
  programs.htop.enable = true;
  home.packages = with pkgs; [
    fd
    eza
    tlrc # tldr in rust
    mission-center
    ncdu
    tor-browser
    peazip
    gnome.pomodoro # TODO impermanence
    vlc
    meld
    element-desktop # TODO impermanence
    zoom-us # TODO impermanence?
    gnumake
  ];
}
