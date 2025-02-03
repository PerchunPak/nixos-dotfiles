{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  networking.hostName = "perchun-pc";

  my = {
    user.password = "$y$j9T$bLmizdUJczqBOKxdu/pC40$d4nIu4bEfXL4FtnuZnS92LEfXdM8kgMidPHMX.hoLuD";
    nvidia.enable = true;
    hyprland.monitors = [ "HDMI-A-2,1920x1080@60,0x0,1" ];
  };
}
