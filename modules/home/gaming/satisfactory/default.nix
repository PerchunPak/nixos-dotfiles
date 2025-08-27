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
    # stable because https://github.com/NixOS/nixpkgs/issues/437439
    home.packages = with pkgs; [ stable.satisfactorymodmanager ];

    my.persistence.directories = [
      ".cache/SatisfactoryModManager"
      ".local/share/SatisfactoryModManager"
      ".local/share/ficsit"
      # server
      ".config/Epic/FactoryGame"
    ];
  };
}
