{
  programs.trippy = {
    enable = true;
    forceUserConfig = true;
    settings = {
      tui = {
        tui-theme = "catppuccin-mocha";
        geoip-mmdb-file = "/home/perchun/persistent/GeoLite2-City.mmdb";
      };
    };
  };
}
