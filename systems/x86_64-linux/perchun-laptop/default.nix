{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })
  ];

  networking.hostName = "perchun-laptop";

  my = {
    nvidia.enable = true;
    zerotier.networks = [ "8850338390436420" ];
    # sleep.disable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
