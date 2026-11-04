{ inputs, ... }:
final: prev: {
  wayle = prev.wayle.overrideAttrs (old: rec {
    src = inputs.wayle;

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-FoHPiv6hoBXyq/bKHLpFHkzMNBbu1GNgFmQLSZGc8Yg=";
    };

    postInstall = (old.postInstall or "") + ''
      install -Dm644 resources/wayle.portal \
        "$out/share/xdg-desktop-portal/portals/wayle.portal"
    '';
  });
}
