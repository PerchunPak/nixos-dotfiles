{ config, ... }:
{
  programs.steam = {
    enable = config.my.gui.enable;
    gamescopeSession.enable = config.my.gui.enable;
  };
  programs.gamemode.enable = config.my.gui.enable;

  environment.variables = {
    FONTCONFIG_PATH = "/etc/fonts";
  };
}
