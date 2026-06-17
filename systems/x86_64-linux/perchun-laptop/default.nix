{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
    ../../../manual-modules/impermanence
  ];

  networking.hostName = "perchun-laptop";
  networking.nameservers = [
    # OpenDNS
    "208.67.222.222"
    "208.67.220.220"
    # NextDNS
    "45.90.28.142"
    "45.90.30.142"
  ];

  my = {
    user.password = "$y$j9T$yfBs4FZDXyK/iBDi9UTo51$ydnsektCwQhSR72L.9OEOyV1cJdREhnlZ5/DHCdC1a5";
    gui.enable = true;
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
    btrfs-snapshots.enable = true;
    # flatpak.enable = true;
  };

  services.power-profiles-daemon.enable = true;

  virtualisation.docker.storageDriver = "btrfs";
}
