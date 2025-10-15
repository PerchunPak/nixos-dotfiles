# https://github.com/doy/rbw/issues/284
{ ... }:
final: prev: {
  rbw = prev.rbw.overrideAttrs (old: {
    patches = (old.patcher or [ ]) ++ [
      (final.fetchpatch {
        url = "https://github.com/doy/rbw/pull/280/commits/f547890a1138798f6f569ad72e3d9be3464af825.patch?full_index=1";
        hash = "sha256-vX1AeeP2q0PjLi28QTePccpAsEX6lg/QXSZkGqmgEAY=";
      })
      (final.fetchpatch {
        url = "https://github.com/doy/rbw/pull/280/commits/4f654938d1845d1be51a02791914227c3862d0e4.patch?full_index=1";
        hash = "sha256-dfMta3BrtSPRpB7l/m1KvDdzG+COtSNjOpCbguHEXDQ=";
      })
    ];
  });
}
