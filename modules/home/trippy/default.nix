{ inputs, ... }:
{
  programs.trippy = {
    enable = true;
    forceUserConfig = true;
    settings =
      (builtins.fromTOML (builtins.readFile "${inputs.ctp-trippy}/themes/catppuccin-mocha.toml"))
      // {
        tui.geoip-mmdb-file = "/home/perchun/persistent/GeoLite2-City.mmdb";
      };
  };
}
