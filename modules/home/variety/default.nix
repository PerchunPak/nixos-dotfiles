{ pkgs, ... }:
{
  home.packages = [ pkgs.variety ];

  # this is what variety generated itself
  home.file.".config/autostart/variety.desktop".text = # ini
    ''
      [Desktop Entry]
      Name=Variety
      Comment=Variety Wallpaper Changer
      Categories=GNOME;GTK;Utility;
      Exec=${pkgs.bash}/bin/bash -c "sleep 20 && ${pkgs.variety}/bin/variety --profile /home/perchun/.config/variety/"
      MimeType=text/uri-list;x-scheme-handler/variety;x-scheme-handler/vrty;
      Icon=variety
      Terminal=false
      Type=Application
      StartupNotify=false
      Actions=Next;Previous;PauseResume;History;Preferences;
      Keywords=Wallpaper;Changer;Change;Download;Downloader;Variety;
      StartupWMClass=Variety
    '';

  xdg.configFile = {
    "variety/ui.conf".source = ./ui.conf;
    "variety/variety.conf".source = ./variety.conf;
  };

  home.file."Pictures/.keep".text = "Variety needs this";

  my.persistence = {
    directories = [ ".config/variety" ];
  };
}
