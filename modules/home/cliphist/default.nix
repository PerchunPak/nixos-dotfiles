{
  nixosConfig,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf nixosConfig.my.gui.enable {
    services.cliphist.enable = true;

    home.packages = [
      (pkgs.writeShellScriptBin "cliphistory" ''
        cliphist list | rofi -dmenu | cliphist decode | wl-copy
      '')
    ];
  };
}
