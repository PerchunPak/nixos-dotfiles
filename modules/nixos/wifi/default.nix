{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    my.wifi = {
      disableOnBoot = lib.mkEnableOption "turning Wi-Fi off on every boot";
    };
  };
  config = lib.mkIf (config.my.wifi.disableOnBoot && config.networking.networkmanager.enable) {
    # NetworkManager reads the radio state from this file on startup. Editing it
    # before NetworkManager starts keeps Wi-Fi from ever coming up, unlike
    # `nmcli radio wifi off` afterwards. It can still be turned on at runtime.
    systemd.services.wifi-off-on-boot = {
      description = "Turn Wi-Fi off before NetworkManager starts";
      wantedBy = [ "NetworkManager.service" ];
      before = [ "NetworkManager.service" ];
      unitConfig.DefaultDependencies = false;
      after = [ "local-fs.target" ];
      serviceConfig.Type = "oneshot";
      path = [
        pkgs.coreutils
        pkgs.gnugrep
        pkgs.gnused
      ];
      script = ''
        state=/var/lib/NetworkManager/NetworkManager.state
        mkdir -p "$(dirname "$state")"
        if [ ! -e "$state" ]; then
          printf '[main]\nWirelessEnabled=false\n' > "$state"
        elif grep -q '^WirelessEnabled=' "$state"; then
          sed -i 's/^WirelessEnabled=.*/WirelessEnabled=false/' "$state"
        elif grep -q '^\[main\]' "$state"; then
          sed -i '/^\[main\]/a WirelessEnabled=false' "$state"
        else
          printf '[main]\nWirelessEnabled=false\n' >> "$state"
        fi
      '';
    };
  };
}
