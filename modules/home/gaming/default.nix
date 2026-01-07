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
    my.gaming = {
      enable = lib.my.mkEnableByDefaultOption "Gaming";
      additional-games = lib.mkOption {
        type = with lib.types; listOf package;
        default = [ ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    my.persistence.directories = [
      ".factorio"
      ".config/heroic"
      ".config/unity3d"
      ".factorio"
      ".local/share/Celeste"
      "Zomboid"
    ];

    home.packages =
      with pkgs;
      [
        wineWowPackages.waylandFull
        heroic
      ]
      ++ cfg.additional-games;
  };
}
