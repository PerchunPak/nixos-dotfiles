{ lib, config, ... }:
let
  cfg = config.my.user;
in
{
  options = {
    my.user = {
      enable = lib.my.mkEnableByDefaultOption "user configuration";
      password = lib.mkOption { type = with lib.types; passwdEntry str; };
    };
  };

  config = lib.mkIf cfg.enable {
    users.users = {
      perchun = {
        isNormalUser = true;
        description = "Perchun Pak";
        hashedPassword = cfg.password;
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
        ];
      };
    };
  };
}
