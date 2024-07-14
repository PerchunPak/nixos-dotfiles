{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  networking.hostName = "perchun-laptop";

  my = {
    user.password = "$y$j9T$27S3SAmwSy9GYZyTvAVI//$kNaRPqAAe5two6jEJdvvg06zrEEJ66LSOh/wnWQtNmA";
    zerotier.networks = [ "8850338390436420" ];
    gnome.wayland = true;
    hyprland.monitors = [ "eDP-1,1920x1080@144,0x0,1" ];
  };
}
