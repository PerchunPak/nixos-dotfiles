{ pkgs, ... }:
{
  xdg.configFile."s-tui/s-tui.conf".source = ./s-tui.conf;

  home.packages = [ pkgs.s-tui ];
}
