{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "perchun-pc";

  # Let sudo to remember my password for longer time
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
    Defaults        lecture=never
  '';

  my = {
    zerotier.networks = ["8850338390436420"];
    disko.device = "/dev/nvme0n1";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
