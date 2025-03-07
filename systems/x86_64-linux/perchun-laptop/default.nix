{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  networking.hostName = "perchun-laptop";

  my = {
    vm.enable = true;
    user.password = "$y$j9T$27S3SAmwSy9GYZyTvAVI//$kNaRPqAAe5two6jEJdvvg06zrEEJ66LSOh/wnWQtNmA";
    nvidia.enable = true;
    hyprland.monitors = [ "eDP-1,1920x1080@144,0x0,1" ];
  };

  services.power-profiles-daemon.enable = true;

  hardware.nvidia.prime = {
    offload.enable = true;

    amdgpuBusId = "PCI:1:0:0";
    nvidiaBusId = "PCI:5:0:0";
  };
}
