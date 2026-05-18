{ inputs, ... }:
final: prev: {
  wayle = prev.wayle.overrideAttrs (old: {
    src = inputs.wayle;

    patches = [
      # https://github.com/wayle-rs/wayle/pull/117
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/59b73b2d30877a2381cd48fdca13bbf346020209.diff?full_index=1";
        hash = "sha256-A5/IEIOmr4Xez8J4EM/sJBHLGuC7zzOA/Mq/sfpVJp0=";
      })
      # https://github.com/wayle-rs/wayle/pull/171
      (final.fetchpatch2 {
        url = "https://github.com/wayle-rs/wayle/commit/518e3ff4c665ba46ab94af383c2e7d3ddde7f2f5.diff?full_index=1";
        hash = "sha256-LBjaXvOFWr0wo5n44lAAOD5ccLWazjZlOCDxnkxtAP0=";
      })
    ];

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit (final.wayle) src;
      hash = "sha256-sXoqNF7hzE97PkRMBnxVFNPa92CgD5gYeMd0RmzPJzY=";
    };

    checkFlags = [
      # https://github.com/wayle-rs/wayle/pull/117#issuecomment-4467043622
      "--skip=shell::bar::modules::media::helpers::tests::resolve_icon_mapped_mode_builtin_fallback"
    ];
  });
}
