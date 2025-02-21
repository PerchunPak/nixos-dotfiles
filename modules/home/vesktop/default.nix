{ pkgs, ... }:
let
  pkg = pkgs.vesktop;
in
{
  home.packages = [ pkg ];

  my.persistence.directories = [ ".config/vesktop" ];

  xdg.configFile = {
    "vesktop/settings" = {
      source = ./settings;
      recursive = true;
    };
    "vesktop/themes" = {
      source = ./themes;
      recursive = true;
    };
  };

  services.arrpc.enable = true;
}
