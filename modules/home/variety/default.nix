{
  pkgs,
  lib,
  nixosConfig,
  ...
}:
{
  config = lib.mkIf nixosConfig.my.gui.enable {
    home.packages = [ pkgs.variety ];

    xdg.configFile = {
      "variety/ui.conf".source = ./ui.conf;
      "variety/variety.conf".source = ./variety.conf;
    };

    home.file."Pictures/.keep".text = "Variety needs this";

    my.persistence = {
      directories = [ ".config/variety" ];
    };
  };
}
