{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.lix-module.nixosModules.default ];

  nixpkgs.overlays = lib.mkForce [ ];
  lix.enable = true;
  nix.package = pkgs.nixVersions.stable;
}
