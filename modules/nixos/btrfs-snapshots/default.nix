{ pkgs, lib, ... }:
let
  btrfs-backup = lib.getExe pkgs.my.btrfs-backup;
in
{
  environment.defaultPackages = [ pkgs.my.btrfs-backup ];

  systemd.services = {
    btrfs-backup-on-boot = {
      description = "Run btrfs-backup on boot";
      script = "${btrfs-backup} --label boot --keep 20 -- /persist";

      serviceConfig.Type = "oneshot";
      serviceConfig.RemainAfterExit = true;
      wantedBy = [ "multi-user.target" ];
      partOf = [ "multi-user.target" ];
      onFailure = [ "btrfs-backup-on-failure.service" ];
    };

    btrfs-backup-quarterly = {
      description = "Run btrfs-backup every 15 minutes";
      script = "${btrfs-backup} --label quarterly --keep 8 -- /persist";

      serviceConfig.Type = "oneshot";
      startAt = "*:0/15";
      onFailure = [ "btrfs-backup-on-failure.service" ];
    };

    btrfs-backup-on-failure = {
      environment = {
        DISPLAY = ":0";
        DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
      };

      script = "${pkgs.libnotify}/bin/notify-send 'btrfs-backup crashed!' 'One of auto-backup scripts just crashed!'";
      serviceConfig.Type = "oneshot";
      serviceConfig.User = "perchun";
    };
  };

  my.persistence.directories = [ "/.btrfs" ];
}
