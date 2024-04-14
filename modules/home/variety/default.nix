{pkgs, ...}: {
  home.packages = [pkgs.variety];

  home.file.".config/autostart/variety.desktop".source = "${pkgs.variety}/share/applications/variety.desktop";

  xdg.configFile = {
    "variety/.firstrun".text = "2023-10-27 11:06:59";
    "variety/Downloaded/.variety_download_folder".text = "2023-10-27 11:06:59";
    "variety/ui.conf".source = ./ui.conf;
    "variety/variety.conf".source = ./variety.conf;
  };

  home.persistence."/persist/home" = {
    directories = [
      ".config/variety/Downloaded"
    ];
    files = [
      ".config/variety/.last_change_time"
      ".config/variety/.version"
      ".config/variety/history.txt"
    ];
  };
}
