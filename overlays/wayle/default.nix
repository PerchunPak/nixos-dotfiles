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

      # https://github.com/wayle-rs/wayle/pull/325
      # feat: optional fallback to symbolic desktop icon
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/a420c316cef733bfb09517e999912d4346d8fd8f.diff?full_index=1";
        hash = "sha256-z6n+2xyT2daFsWyRIcTKw2yyJi38DTMOiYz5xZD0Fl0=";
      })
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/9ebf9bb8d89ca406a6947e407b8cc484222e48b0.diff?full_index=1";
        hash = "sha256-r0WC3yRkUXbyCsvQQM0g/VAjyYWmnHPtFMtADiM55Zc=";
      })
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/557d1b3e1964ab3fe97e60586694cf66edf1e1a6.diff?full_index=1";
        hash = "sha256-Zy/5A1gh0pn3hI5xCa24qaGvh9pAHqmRVaOBX8NohCo=";
      })
      ./show-color-icons.patch
    ];

    cargoDeps =
      assert old.cargoHash == "sha256-4PUXJwUP5h/ggZQbY78BdqMh5oZes1XCeWuT2/S94Z4=";
      final.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-ZvwScjQ+MgVFmIYCSbOjmjh128FomUaIq3cl4hV2s54=";
      };
  });
}
