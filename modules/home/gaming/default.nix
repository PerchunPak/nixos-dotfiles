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
    home.packages = with pkgs; [ wineWowPackages.full ] ++ cfg.additional-games;
  };
}
