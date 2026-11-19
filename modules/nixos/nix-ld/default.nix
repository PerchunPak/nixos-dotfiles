{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      e2fsprogs
      gcc16.cc
      # opencv-python and mediapipe wheels
      glib
      libglvnd
      libxcb
    ];
  };

  environment.systemPackages = with pkgs; [ steam-run ];
}
