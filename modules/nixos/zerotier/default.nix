{ lib, config, ... }:
let
  cfg = config.my.zerotier;
in
{
  options = {
    my.zerotier = {
      enable = lib.my.mkEnableByDefaultOption "zerotier";
      networks = lib.mkOption { type = lib.types.listOf lib.types.str; };
    };
  };

  config = lib.mkIf cfg.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = cfg.networks;
    };

    my.persistence.directories = [ "/var/lib/zerotier-one" ];
  };
}
