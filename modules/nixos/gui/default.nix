{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    my.gui = {
      enable = lib.mkEnableOption "GUI";
    };
  };

  config = lib.mkIf config.my.gui.enable {
    services.xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };

    programs.xwayland.enable = true;
  };
}
