{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      e2fsprogs
      libgcc
    ];
  };

  environment.systemPackages = with pkgs; [ steam-run ];
}
