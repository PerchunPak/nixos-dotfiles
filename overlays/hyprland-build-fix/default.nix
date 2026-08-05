{ ... }:
final: prev: {
  # https://github.com/NixOS/nixpkgs/pull/549253#issuecomment-5187116010
  hyprland =
    assert (builtins.match ".*Relax glaze dependency.*" prev.hyprland.postPatch) != [ ];
    prev.hyprland.overrideAttrs (oldAttrs: {
      postPatch = ''
        substituteInPlace CMakeLists.txt start/CMakeLists.txt hyprpm/CMakeLists.txt \
          --replace-fail "glaze 7...<8" "glaze"
      ''
      + (oldAttrs.postPatch or "");
    });
}
