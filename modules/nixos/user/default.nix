{ lib, config, ... }:
let
  cfg = config.my.user;
in
{
  options = {
    my.user = {
      password = lib.mkOption { type = with lib.types; passwdEntry str; };
    };
  };

  config = {
    users.users = {
      perchun = {
        isNormalUser = true;
        description = "Perchun Pak";
        hashedPassword = cfg.password;
        createHome = true;
        extraGroups = [
          "docker"
          "input"
          "libvirtd"
          "networkmanager"
          "video"
          "wheel"
        ];
      };
    };

    nix.settings.trusted-users = [ "@wheel" ];
  };
}
