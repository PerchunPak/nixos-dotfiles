{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      e2fsprogs
      gcc16.cc
    ];
  };

  environment.systemPackages = with pkgs; [ steam-run ];
}
