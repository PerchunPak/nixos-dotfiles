{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.gaming;
in
{
  options = {
    my.gaming.satisfactory = {
      enable = (lib.my.mkEnableByDefaultOption "Satisfactory") // {
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.minecraft.enable {
    home.packages = with pkgs; [ satisfactorymodmanager ];

    my.persistence.directories = [
      ".cache/SatisfactoryModManager"
      ".local/share/SatisfactoryModManager"
    ];
  };
}
