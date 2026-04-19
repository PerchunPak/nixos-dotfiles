{ inputs, ... }:
final: prev: {
  gh-cherry-pick = prev.gh-cherry-pick.overrideAttrs {
    src = inputs.gh-cherry-pick;
  };
  wayle = prev.wayle.overrideAttrs {
    src = inputs.wayle;

    patches = [
      # https://github.com/wayle-rs/wayle/pull/117
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/cc5964265e7b59c0a79d17f0c7b9254d88e54131.diff";
        hash = "sha256-RKlXOupt7ia5pHISYoimxdtpWof+coj+SanN5iD8Y1k=";
      })
    ];

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit (final.wayle) src;
      hash = "sha256-omCcKXYouS9qPdhVINJC2mAjI7uG0M9MH14BN/4Zegs=";
    };
  };
}
