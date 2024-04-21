{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "perchun-pc";

  my = {
    nvidia.enable = true;
    zerotier.networks = ["8850338390436420"];
    disko.device = "/dev/nvme0n1";
    sleep.disable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
