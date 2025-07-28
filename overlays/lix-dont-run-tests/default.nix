{ ... }:
final: prev: {
  lix = prev.lix.overrideAttrs { doCheck = false; };
}
