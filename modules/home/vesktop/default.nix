{ pkgs, ... }:
{
  home.packages = [ pkgs.vesktop ];

  my.persistence.directories = [ ".config/vesktop" ];

  xdg.configFile = {
    "vesktop/settings" = {
      source = ./settings;
      recursive = true;
    };
  };

  services.arrpc.enable = true;
}
