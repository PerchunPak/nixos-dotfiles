{ ... }:
final: prev: {
  wayle = prev.wayle.overrideAttrs (old: {
    patches = old.patches or [ ] ++ [
      (final.fetchpatch {
        url = "https://github.com/Jas-SinghFSU/wayle/commit/b4d70c358a0c69c8bc337326d85a011233c4861b.diff?full_index=1";
        hash = "sha256-t9UGj01B9vGfAFTW7exnfGUjaYrvdC9amsRq7ZUBmTk=";
      })
      (final.fetchpatch {
        url = "https://github.com/Jas-SinghFSU/wayle/commit/5d9b5a4ad4cfe538c4fe5153d49a1071609c099c.diff?full_index=1";
        hash = "sha256-0sLh5slB0aU98qp6Lq26nTK5IDvIg/dlg+zgQ+thfuM=";
      })
    ];
  });
}
