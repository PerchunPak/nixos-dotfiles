# see https://github.com/gytis-ivaskevicius/flake-utils-plus/issues/145
{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.latest;
}
