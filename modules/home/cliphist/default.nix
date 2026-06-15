{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.gui.enable {
    services.cliphist.enable = true;

    home.packages = [
      (pkgs.writeShellScriptBin "cliphistory" ''
        cliphist list | rofi -dmenu | cliphist decode | wl-copy
      '')
    ];
  };
}
