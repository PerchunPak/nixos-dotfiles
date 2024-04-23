{ pkgs, config, ... }:
{
  home.packages = [ pkgs.qbittorrent ];

  my.persistence.directories = [
    "torrents"
    ".config/qBittorrent"
  ];

  xdg.configFile."qBittorrent-example" = {
    source = ./configs;
    recursive = true;
  };

  # Add program to autostart
  home.file.".config/autostart/org.qbittorrent.qBittorrent.desktop".source = "${pkgs.qbittorrent}/share/applications/org.qbittorrent.qBittorrent.desktop";

  # Copy configuration file, if it doesn't exists yet
  # (qBittorrent writes to its config file)
  my.setup-stuff.qbittorrent-config.command = ''
    /usr/bin/env bash -c '${pkgs.coreutils}/bin/cp -rn ${config.xdg.configHome}/qBittorrent-example/. ${config.xdg.configHome}/qBittorrent || true'
  '';
}
