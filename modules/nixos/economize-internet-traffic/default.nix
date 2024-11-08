{ lib, ... }:
{
  options.my = {
    economInternetTraffic = lib.mkEnableOption "Econom internet traffic";
  };
}
