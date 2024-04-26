{ osConfig, lib, ... }:
{
  config = lib.mkIf osConfig.my.gaming.steam.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        fps_limit = 165;
      };
    };
  };
}
