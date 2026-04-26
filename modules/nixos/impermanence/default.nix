{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.persistence;
  impermanenceOptions = lib.my.getImpermanenceOptions { inherit pkgs inputs config; };
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    (lib.modules.mkAliasOptionModule [ "my" "persistence" ] [ "environment" "persistence" "/persist" ])
  ];

  config = {
    boot.initrd.systemd = {
      initrdBin = with pkgs; [
        btrfs-progs
        coreutils
        util-linux
        findutils
      ];

      services.prune-subvolumes = {
        requiredBy = [ "initrd.target" ];
        before = [ "local-fs-pre.target" ];
        after = [
          "initrd-root-device.target"
          "systemd-hibernate-resume.service"
        ];
        unitConfig.DefaultDependencies = false;
        serviceConfig = {
          Type = "oneshot";
          # also print to TTY
          StandardOutput = "journal+console";
          StandardError = "journal+console";
        };
        script = ''
          set -e
          MOUNTDIR=/mnt
          BTRFS_VOL=/dev/mapper/root_vg-root

          echo "Mounting btrfs..."
          mkdir -p $MOUNTDIR
          mount -t btrfs -o subvol=/,user_subvol_rm_allowed $BTRFS_VOL $MOUNTDIR

          echo "Deleting old subvolumes"
          for old_subvolume in $(find $MOUNTDIR/old_roots/ -maxdepth 1 -mtime +30); do
            echo "Deleting $old_subvolume"
            btrfs subvolume delete -R "$old_subvolume"
          done

          if [[ -e $MOUNTDIR/root ]]; then
            echo "Moving existing root to the old_roots directory..."
            mkdir -p $MOUNTDIR/old_roots
            timestamp=$(date --date="@$(stat -c %Y $MOUNTDIR/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv $MOUNTDIR/root "$MOUNTDIR/old_roots/$timestamp"
            btrfs property set "$MOUNTDIR/old_roots/$timestamp" ro true
          fi

          btrfs subvolume create $MOUNTDIR/root
          umount $MOUNTDIR
          echo "Done!"
        '';
      };
    };

    # Ensure that all files are properly chowned
    # https://github.com/Misterio77/nix-config/blob/61aa0ab5e26c528eb6be98dee1a8b9061003bf2e/hosts/common/global/optin-persistence.nix#L29-L38
    system.activationScripts.persistent-dirs.text =
      let
        mkHomePersist =
          user:
          lib.optionalString user.createHome ''
            mkdir -p /persist/${user.home}
            chown ${user.name}:${user.group} /persist/${user.home}
            chmod ${user.homeMode} /persist/${user.home}
          '';
        users = lib.attrValues config.users.users;
      in
      lib.concatLines (map mkHomePersist users);

    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [ "/etc/machine-id" ];
    };

    security.sudo.extraConfig = ''
      Defaults        lecture=never
    '';
  };
}
