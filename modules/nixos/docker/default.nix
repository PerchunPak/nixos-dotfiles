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
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      daemon.settings.data-root = "/persist/system/docker";
      enableOnBoot = false;
    };
  };
}
