{ config, ... }:
{
  qt = {
    enable = config.my.gui.enable;
    platformTheme = "qt5ct";
  };
}
