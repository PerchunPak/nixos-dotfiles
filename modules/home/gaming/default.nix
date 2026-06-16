{
  lib,
  config,
  nixosConfig,
  pkgs,
  ...
}:
let
  cfg = config.my.gaming;
in
{
  options = {
    my.gaming = {
      enable = (lib.my.mkEnableByDefaultOption "Gaming") // {
        default = nixosConfig.my.gui.enable;
      };
      additional-games = lib.mkOption {
        type = with lib.types; listOf package;
        default = [ ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    my.persistence.directories = [
      ".config/heroic"
    ];

    home.packages =
      with pkgs;
      [
        wineWow64Packages.waylandFull
        heroic
      ]
      ++ cfg.additional-games;
  };
}
