{ pkgs, lib, ... }:
{
  systemd.user.services.usbguard-notifier = {
    Unit = {
      Description = "USBGuard Notifier";
      After = [ "usbguard.service" ];
    };
    Service = {
      ExecStart = lib.getExe pkgs.usbguard-notifier;
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
