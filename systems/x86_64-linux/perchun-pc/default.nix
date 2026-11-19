{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
    ../../../manual-modules/impermanence
    ../../../manual-modules/dns.nix
    ./openrgb
  ];

  networking.hostName = "perchun-pc";

  my = {
    user.password = "$y$j9T$d9jmKHxBK8BbsxiDQ94GV/$7x8GrN32KPK7cX9zWPaOwjDfqb58d7cvjDw3/f/Fg81";
    gui.enable = true;
    hyprland.monitors = [
      {
        output = "DP-2";
        mode = "2560x1440@239.97";
        position = "0x0";
        scale = 1;
      }
    ];
    btrfs-snapshots.enable = true;
    wifi.disableOnBoot = true;
    amdgpu.enable = true;
    # flatpak.enable = true;
  };

  virtualisation.docker.storageDriver = "btrfs";
}
