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

  config = lib.mkMerge [
    {
      # not settings this may delete my data, better to keep empty symlink
      my.persistence.directories = [
        ".factorio"
        ".config/heroic"
        ".config/unity3d"
        "Zomboid"
      ];
    }
    (lib.mkIf cfg.enable {
      home.packages =
        with pkgs;
        [
          wineWowPackages.waylandFull
          heroic
        ]
        ++ cfg.additional-games;
    })
  ];
}
