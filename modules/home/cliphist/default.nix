{ pkgs, ... }:
{
  services.cliphist.enable = true;

  home.packages = [
    (pkgs.writeShellScriptBin "cliphistory" ''
      cliphist list | rofi -dmenu | cliphist decode | wl-copy
    '')
  ];
}
