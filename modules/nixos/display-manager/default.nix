{ config, ... }:
{
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "perchun";
    };
    ly = {
      enable = config.my.gui.enable;
      settings = {
        animation = "gameoflife";
        bigclock = "en";
        bigclock_seconds = true;
        hide_version_string = true;
        inactivity_cmd = "systemctl suspend";
        inactivity_delay = 5 * 60;
        sleep_cmd = "systemctl suspend";
        numlock = true;
      };
    };
  };
}
