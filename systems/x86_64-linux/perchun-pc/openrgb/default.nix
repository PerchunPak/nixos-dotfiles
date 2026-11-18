{ lib, pkgs, ... }:
let
  stateDir = "/var/lib/OpenRGB";
  profile = "gta6";

  # Merged into the service's OpenRGB.json on every start. The GUI connects
  # to the service and reads its ProfileManager settings from there.
  settings = pkgs.writeText "openrgb-settings.json" (
    builtins.toJSON {
      ProfileManager = {
        # The service has no plugins, so this only restores device modes.
        service_startup_profile = {
          enabled = true;
          name = profile;
        };
        # The GUI loads the Effects plugin, so this starts the effects.
        open_profile = {
          enabled = true;
          name = profile;
        };
      };
      # See overlays/openrgb-asrock-rgswap.
      "ASRock Polychrome USB".RGSwap = {
        "Addressable Header 1" = false;
        "Addressable Header 2" = false;
        "Addressable Header 3/Audio" = false;
        "IO Cover" = true;
        "PCB" = true;
        "PCH" = true;
        "RGB LED 1 Header" = false;
        "RGB LED 2 Header" = false;
      };
    }
  );
in
{
  # /var/lib/OpenRGB is not persisted, so restore the state on every start.
  # Changes saved from the GUI are overwritten on the next service restart;
  # copy them back into this directory to keep them.
  systemd.services.openrgb.preStart = ''
    install -Dm644 ${./${profile}.json} ${stateDir}/profiles/${profile}.json
    # Manually resized zones (ARGB header LED counts).
    install -Dm644 ${./Configuration.json} ${stateDir}/Configuration.json

    config=${stateDir}/OpenRGB.json
    [ -s "$config" ] || echo '{}' > "$config"
    ${lib.getExe pkgs.jq} -s '.[0] * .[1]' "$config" ${settings} > "$config.tmp"
    mv "$config.tmp" "$config"
  '';
}
