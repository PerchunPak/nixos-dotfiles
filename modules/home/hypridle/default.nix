{
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
      before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
      after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
    };

    listener = [
      {
        timeout = 5 * 60;
        on-timeout = "light -S 10";
        on-resume = "light -I";
      }
      {
        timeout = 8 * 60;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
      {
        timeout = 10 * 60;
        on-timeout = "loginctl lock-session";
      }
      {
        timeout = 15 * 60;
        on-timeout = "systemctl suspend";
      }
    ];
  };
}
