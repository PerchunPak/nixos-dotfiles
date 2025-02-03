{ lib, config, ... }:
let
  cfg = config.my.zerotier;
in
{
  options = {
    my.zerotier = {
      enable = lib.mkEnableOption "zerotier";
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
