{ inputs, ... }:
final: prev: {
  # by using `inputs.nix-diff-rs.packages.default` it somehow triggers
  # `x86_64-darwin` deprecation warning
  nix-diff-rs = final.pkgs.callPackage "${inputs.nix-diff-rs}/package.nix" { };
}
