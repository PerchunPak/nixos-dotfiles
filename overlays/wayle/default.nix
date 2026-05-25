{ inputs, ... }:
final: prev: {
  wayle = prev.wayle.overrideAttrs (old: {
    src = inputs.wayle;

    patches = [
      # https://github.com/wayle-rs/wayle/pull/117
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/2cdcbab0b3637653c5ec2c5c4d9ff46ac90e9eef.diff?full_index=1";
        hash = "sha256-gDFpC23P3rl9TG5j+lqOE3pnJoyKZ5pD0QtHOZ5rUGk=";
      })
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/3bab4b752f5b93e89333d19b85cbda55d7be1f6f.diff?full_index=1";
        hash = "sha256-XSqZmrqEg6Db1+PZUCDxxTLu4NSF8w0sZPtAkaZT2iI=";
      })
    ];
  });
}
