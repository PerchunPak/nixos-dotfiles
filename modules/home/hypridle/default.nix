{ pkgs, lib, ... }:
let
  light = lib.getExe pkgs.brightnessctl;
in
{
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
      before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
      after_sleep_cmd = "${light} -r"; # restore brightness immediately after wake.
    };

    listener = [
      {
        timeout = 5 * 60;
        on-timeout = "${light} -s && ${light} set 0%";
        on-resume = "${light} -r";
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
