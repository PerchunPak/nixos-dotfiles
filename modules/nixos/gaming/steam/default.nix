{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  environment.variables = {
    FONTCONFIG_PATH = "/etc/fonts";
  };
}
