{
  lib,
  config,
  ...
}:
let
  cfg = config.my.ydotool;
in
{
  options = {
    my.ydotool = {
      enable = lib.mkEnableOption "ydotool";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ydotool.enable = true;

    users.users.perchun.extraGroups = [ "ydotool" ];
  };
}
