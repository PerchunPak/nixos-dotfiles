{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.btrfs-snapshots;
  btrfs-backup = lib.getExe pkgs.my.btrfs-backup;
  subvolumes = lib.escapeShellArgs cfg.subvolumes;
in
{
  options = {
    my.btrfs-snapshots = {
      enable = lib.mkEnableOption "btrfs snapshots";
      subvolumes = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
        description = "Subvolumes to snapshot. Nested subvolumes are excluded from their parent's snapshots, so list them here to back them up.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    my.btrfs-snapshots.subvolumes = lib.mkBefore [ "/persist" ];

    environment.defaultPackages = [ pkgs.my.btrfs-backup ];

    systemd.services = {
      btrfs-backup-on-boot = {
        description = "Run btrfs-backup on boot";
        script = "${btrfs-backup} --label boot --keep 5 -- ${subvolumes}";

        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
        wantedBy = [ "multi-user.target" ];
        partOf = [ "multi-user.target" ];
        onFailure = [ "btrfs-backup-on-failure.service" ];
      };

      btrfs-backup-quarterly = {
        description = "Run btrfs-backup every 15 minutes";
        script = "${btrfs-backup} --label quarterly --keep 8 -- ${subvolumes}";

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
  };
}
