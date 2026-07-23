{ inputs, ... }:
final: prev: {
  wayle = prev.wayle.overrideAttrs (old: rec {
    src = inputs.wayle;

    patches = [
      # https://github.com/wayle-rs/wayle/pull/117
      # fix: avoid using generic glob patterns for most application icons
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/2cdcbab0b3637653c5ec2c5c4d9ff46ac90e9eef.diff?full_index=1";
        hash = "sha256-gDFpC23P3rl9TG5j+lqOE3pnJoyKZ5pD0QtHOZ5rUGk=";
      })
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/3bab4b752f5b93e89333d19b85cbda55d7be1f6f.diff?full_index=1";
        hash = "sha256-XSqZmrqEg6Db1+PZUCDxxTLu4NSF8w0sZPtAkaZT2iI=";
      })

      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/c66d83a04d03ecc688149f36ac154b5cff9b1bf6.diff?full_index=1";
        hash = "sha256-hu2KPcR0PcVBBrtH3GXbwnNiXGLf/R5qK5gHqLuvARg=";
        revert = true;
      })
      ./show-color-icons.patch
    ];

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-aRLwgI7j3vfG3A/OAHKg6jUwWRrrIgRxRe4U5ZeMoKM=";
    };

    postInstall = (old.postInstall or "") + ''
      install -Dm644 resources/wayle.portal \
        "$out/share/xdg-desktop-portal/portals/wayle.portal"
    '';
  });
}
