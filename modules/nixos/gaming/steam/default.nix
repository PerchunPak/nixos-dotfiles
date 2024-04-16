{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.gaming.steam;
in {
  options = {
    my.gaming.steam = {
      enable = lib.my.mkEnableByDefaultOption "Steam";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
