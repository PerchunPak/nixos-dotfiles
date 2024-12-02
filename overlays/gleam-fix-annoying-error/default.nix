{ ... }:
final: prev: {
  gleam = prev.gleam.overrideAttrs (oa: {
    patches = (oa.patches or [ ]) ++ [
      (final.fetchpatch {
        url = "https://patch-diff.githubusercontent.com/raw/gleam-lang/gleam/pull/3855.patch?full_index=1";
        hash = "sha256-Kejh8fWhsMS3jLZIDBys1h4Xo4RbL8Axg0punoVFlsU=";
        excludes = [ "CHANGELOG.md" ];
      })
    ];
  });
}
