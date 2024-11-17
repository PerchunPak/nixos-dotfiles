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
    "autostart/vesktop.desktop".source = "${pkg}/share/applications/vesktop.desktop";
  };

  services.arrpc.enable = true;
}
