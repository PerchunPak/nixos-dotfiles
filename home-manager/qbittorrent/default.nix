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
  systemd.user.services."setup-qbittorrent" = {
    Unit = {
      After = ["multi-user.target"];
      # 3 total retries
      StartLimitIntervalSec = 0;
      StartLimitBurst = 3;
    };

    Install.WantedBy = ["default.target"];
    Service = {
      Type = "oneshot";
      RestartSec = 5;
      Restart = "onfailure";
      ExecStart = ''
        ${pkgs.coreutils}/bin/cp -rn ${config.xdg.configHome}/qBittorrent-example/. ${config.xdg.configHome}/qBittorrent
      '';
    };
  };
}
