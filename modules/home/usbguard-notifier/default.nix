{
  pkgs,
  lib,
  config,
  ...
}:
{
  systemd.user.services.usbguard-notifier = lib.mkIf config.my.gui.enable {
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
