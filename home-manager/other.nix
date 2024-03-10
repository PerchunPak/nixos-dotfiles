{pkgs, ...}: {
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  home.packages = with pkgs; [
    fd
    eza
    tlrc # tldr in rust
  ];
}
