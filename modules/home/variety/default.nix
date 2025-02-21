{ pkgs, ... }:
{
  home.packages = [ pkgs.variety ];

  xdg.configFile = {
    "variety/ui.conf".source = ./ui.conf;
    "variety/variety.conf".source = ./variety.conf;
  };

  home.file."Pictures/.keep".text = "Variety needs this";

  my.persistence = {
    directories = [ ".config/variety" ];
  };
}
