{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  networking.hostName = "perchun-laptop";

  my = {
    vm.enable = true;
    user.password = "$y$j9T$yfBs4FZDXyK/iBDi9UTo51$ydnsektCwQhSR72L.9OEOyV1cJdREhnlZ5/DHCdC1a5";
    nvidia.enable = true;
    hyprland.monitors = [
      "eDP-1,1920x1080@144,0x0,1"
      "HDMI-A-1,1920x1080@60,1920x0,1"
    ];
    ydotool.enable = true;
  };

  services.power-profiles-daemon.enable = true;
}
