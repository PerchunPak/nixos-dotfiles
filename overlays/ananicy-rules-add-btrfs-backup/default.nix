{ ... }:
final: prev: {
  ananicy-rules-cachyos = prev.ananicy-rules-cachyos.overrideAttrs (old: {
    postPatch =
      (old.postPatch or "")
      + ''
        echo "{ "name": "btrfs-backup", "type": "BG_CPUIO" }" >> 00-default/Services/misc-services.rules
      '';
  });
}
