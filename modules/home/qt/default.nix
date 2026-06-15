{ config, ... }:
{
  catppuccin = {
    qt5ct = {
      enable = config.my.gui.enable;
      flavor = "macchiato";
    };
    kvantum.enable = false;
  };

  qt = {
    enable = config.my.gui.enable;
    platformTheme.name = "qtct";
    style.name = "darkly";
  };
}
