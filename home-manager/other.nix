{pkgs, ...}: {
  programs.ripgrep.enable = true;
  home.packages = with pkgs; [fd];
}
