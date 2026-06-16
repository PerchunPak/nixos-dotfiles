{ config, ... }:
{
  programs.ydotool.enable = config.my.gui.enable;
  users.users.perchun.extraGroups = [ "ydotool" ];
}
