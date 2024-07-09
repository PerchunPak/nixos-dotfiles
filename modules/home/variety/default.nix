{ pkgs, ... }:
{
  home.packages = [ pkgs.variety ];

  home.file.".config/autostart/variety.desktop".source = "${pkgs.variety}/share/applications/variety.desktop";

  xdg.configFile = {
    "variety/ui.conf".source = ./ui.conf;
    "variety/variety.conf".source = ./variety.conf;
  };

  my.persistence = {
    directories = [ ".config/variety" ];
  };
}
