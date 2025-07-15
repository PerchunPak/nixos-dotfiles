# https://github.com/NixOS/nixpkgs/issues/425323
{ ... }:
final: prev: {
  jdk8 = prev.jdk8.overrideAttrs {
    separateDebugInfo = false;
    __structuredAttrs = false;
  };
}
