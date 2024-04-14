{
  lib,
  config,
  ...
}: let
  cfg = config.my.user;
in {
  options = {
    my.user = {
      enable = lib.my.mkEnableByDefaultOption "user configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users = {
      perchun = {
        isNormalUser = true;
        description = "Perchun Pak";
        hashedPassword = "$y$j9T$K1EYVhXG6o2yQPH4IUDsw0$P8nQZaE554VdULdAdPmJ2Z9S/fwQ132V6oYiM.RGZWB";
        extraGroups = ["wheel" "networkmanager" "docker"];
      };
    };
  };
}
