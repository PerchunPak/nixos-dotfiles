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
      additional-games = lib.mkOption { type = with lib.types; listOf package; };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ wineWowPackages.stable ] ++ cfg.additional-games;
  };
}
