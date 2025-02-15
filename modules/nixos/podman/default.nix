{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.podman;
in
{
  options = {
    my.podman = {
      enable = lib.my.mkEnableByDefaultOption "podman";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = [ pkgs.podman-compose ];
    my.persistence.directories = [ "/var/lib/containers" ];
  };
}
