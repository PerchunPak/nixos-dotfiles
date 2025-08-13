{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  networking.hostName = "perchun-laptop";

  my = {
    vm.enable = true;
    user.password = "$y$j9T$1YPlnzEYbO2DKNH315Rx80$0Pz6NUYqmHGYMJ9KB0pEJ9Ph3hvWrRP8XV3HOap0q/1";
    nvidia.enable = true;
    hyprland.monitors = [ "eDP-1,1920x1080@144,0x0,1" ];
    ydotool.enable = true;
  };

  services.power-profiles-daemon.enable = true;
}
