{ nixosConfig, pkgs, ... }:
{
  home.packages = with pkgs; [
    morewaita-icon-theme
  ];

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

    qt5ctSettings = {
      Appearance.icon_theme = "MoreWaita";
    };
    qt6ctSettings = {
      Appearance.icon_theme = "MoreWaita";
    };
  };

  gtk = {
    enable = nixosConfig.my.gui.enable;
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
  };
}
