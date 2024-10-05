{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  networking.hostName = "perchun-pc";

  my = {
    user.password = "$y$j9T$K1EYVhXG6o2yQPH4IUDsw0$P8nQZaE554VdULdAdPmJ2Z9S/fwQ132V6oYiM.RGZWB";
    nvidia.enable = true;
    zerotier.networks = [ "8850338390436420" ];
    hyprland.monitors = [ "HDMI-A-2,1920x1080@60,0x0,1" ];
  };
}
