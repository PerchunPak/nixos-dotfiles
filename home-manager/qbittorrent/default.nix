{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.qbittorrent];
  home.persistence."/persist/home".directories = [".config/qBittorrent"];
  xdg.configFile."qBittorrent-example" = {
    source = ./configs;
    recursive = true;
  };

  # Add program to autostart
  home.file.".config/autostart/org.qbittorrent.qBittorrent.desktop".source = "${pkgs.qbittorrent}/share/applications/org.qbittorrent.qBittorrent.desktop";

  # Copy configuration file, if it doesn't exists yet
  # (qBittorrent writes to its config file)
  my.setup-stuff.qbittorrent-config = {
    enabled = true;
    command = ''
      ${pkgs.coreutils}/bin/cp -rn ${config.xdg.configHome}/qBittorrent-example/. ${config.xdg.configHome}/qBittorrent
    '';
  };
}
