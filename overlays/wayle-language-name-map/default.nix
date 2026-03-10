{ ... }:
final: prev: {
  wayle = prev.wayle.overrideAttrs (old: {
    patches = old.patches or [ ] ++ [
      (final.fetchpatch {
        url = "https://github.com/Jas-SinghFSU/wayle/commit/b4d70c358a0c69c8bc337326d85a011233c4861b.diff?full_index=1";
        hash = "sha256-t9UGj01B9vGfAFTW7exnfGUjaYrvdC9amsRq7ZUBmTk=";
      })
    ];
  });
}
