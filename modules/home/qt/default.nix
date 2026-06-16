{ nixosConfig, ... }:
{
  catppuccin = {
    qt5ct = {
      enable = nixosConfig.my.gui.enable;
      flavor = "macchiato";
    };
    kvantum.enable = false;
  };

  qt = {
    enable = nixosConfig.my.gui.enable;
    platformTheme.name = "qtct";
    style.name = "darkly";
  };
}
