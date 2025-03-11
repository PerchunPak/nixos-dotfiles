{
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.persistence;
  cfgHm = user: config.home-manager.users.${user}.my.persistence;
  hmUsers = builtins.attrNames config.home-manager.users;
in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options = {
    my.persistence = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
    };
  };

  config = {
    boot.initrd.postDeviceCommands =
      lib.mkAfter # bash
        ''
          mkdir /btrfs_tmp
          mount /dev/mapper/root_vg-root /btrfs_tmp
          if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
          fi

          delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
          }

          for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$i"
          done

          btrfs subvolume create /btrfs_tmp/root
          umount /btrfs_tmp
        '';

    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ] ++ cfg.directories;
      files = [ "/etc/machine-id" ] ++ cfg.files;

      users = builtins.listToAttrs (
        lib.forEach hmUsers (user: {
          name = user;
          value = cfgHm user;
        })
      );
    };

    security.sudo.extraConfig = ''
      Defaults        lecture=never
    '';
  };
}
