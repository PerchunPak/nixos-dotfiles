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
      {
        output = "eDP-1";
        mode = "1920x1080@144";
        position = "0x0";
        scale = 1;
      }
      {
        output = "HDMI-A-1";
        mode = "1920x1080@60";
        position = "1920x0";
        scale = 1;
      }
    ];
    ydotool.enable = true;
    # flatpak.enable = true;
  };

  services.power-profiles-daemon.enable = true;
}
