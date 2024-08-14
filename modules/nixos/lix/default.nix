{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.stable; # should point to lix
}
