{ pkgs, ... }:
{
  environment.defaultPackages = [ pkgs.my.btrfs-backup ];

  systemd.services =
    let
      variations = [
        {
          name = "quarterly";
          systemdFormat = "*:15,30,45";
          toKeep = 4;
        }
        {
          name = "hourly";
          systemdFormat = null;
          toKeep = 8;
        }
        {
          name = "daily";
          systemdFormat = null;
          toKeep = 8;
        }
        {
          name = "weekly";
          systemdFormat = null;
          toKeep = 5;
        }
        {
          name = "monthly";
          systemdFormat = null;
          toKeep = 3;
        }
      ];

      all-subvolumes = # bash
        "/ $(btrfs subvolume list -o / | cut -f 9- -d ' ' | grep -v '.btrfs/@snapshots' | sed 's/root//')";
    in
    builtins.listToAttrs (
      map (variation: {
        name = "btrfs-backup_${variation.name}";
        value = {
          path = with pkgs; [
            my.btrfs-backup
            btrfs-progs
            busybox
          ];

          script = "btrfs-backup --label ${variation.name} --keep ${toString variation.toKeep} -- ${all-subvolumes}";
          serviceConfig.User = "root";
          startAt = if variation.systemdFormat != null then variation.systemdFormat else variation.name;
          onFailure = [ "btrfs-backup-on-failure.service" ];
        };
      }) variations
    )

    // {
      btrfs-backup-on-failure = {
        environment = {
          DISPLAY = ":0";
          DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
        };

        script = "${pkgs.libnotify}/bin/notify-send 'One of auto-backup scripts just crashed!'";
        serviceConfig.Type = "oneshot";
        serviceConfig.User = "perchun";
      };
    };

  my.persistence.directories = [ "/.btrfs" ];
}
