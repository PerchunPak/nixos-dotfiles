{ lib, ... }:
{
  options = {
    my.gui = {
      enable = lib.mkEnableOption "GUI";
    };
  };
}
