{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  programs.xwayland.enable = true;
}
