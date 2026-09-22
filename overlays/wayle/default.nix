{ inputs, ... }:
final: prev: {
  wayle = prev.wayle.overrideAttrs (old: rec {
    src = inputs.wayle;

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-vBE8ATQEwJIOaR53koDmbaN7H9MULZrPYwi+/L6XbpQ=";
    };

    postInstall = (old.postInstall or "") + ''
      install -Dm644 resources/wayle.portal \
        "$out/share/xdg-desktop-portal/portals/wayle.portal"
    '';
  });
}
