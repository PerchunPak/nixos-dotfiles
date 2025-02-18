{ lib, config, ... }:
let
  cfg = config.my.docker;
in
{
  options = {
    my.docker = {
      enable = lib.my.mkEnableByDefaultOption "Docker";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      storageDriver = "btrfs";
      daemon.settings.data-root = "/persist/system/docker";
      enableOnBoot = false;
    };
  };
}
