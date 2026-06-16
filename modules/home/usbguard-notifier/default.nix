{
  pkgs,
  lib,
  nixosConfig,
  ...
}:
{
  home.packages = lib.mkIf nixosConfig.my.gui.enable [ pkgs.pkgs.usbguard-notifier ];
  systemd.user.services.usbguard-notifier = lib.mkIf nixosConfig.my.gui.enable {
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
