{ ... }:
final: prev: {
  rbw = prev.rbw.overrideAttrs (
    let
      version = "1.13.2";
      src = final.fetchzip {
        url = "https://git.tozt.net/rbw/snapshot/rbw-${version}.tar.gz";
        hash = "sha256-ebLbdIF+BybK7ssNtZacGWmAEwdNZh8b94QYgvcwzmM=";
      };
    in
    {
      inherit version src;
      cargoDeps = final.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-xDb4shDHCbd0yuTSAt80i1aqyuhpkfd/fYF98CfXdcM=";
      };
    }
  );
}
