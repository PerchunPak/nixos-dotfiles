{ ... }:
final: prev: {
  # see https://github.com/NixOS/nixpkgs/issues/338315
  cudaPackages = final.cudaPackages_12_3;
}
