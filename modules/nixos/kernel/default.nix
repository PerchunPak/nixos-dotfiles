{ pkgs, ... }:
{
  # use latest kernel because i can
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
