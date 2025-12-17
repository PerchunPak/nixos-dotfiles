{ pkgs, ... }:
{
  environment.defaultPackages = with pkgs; [ ];

  # should point to lix
  nix.package = pkgs.nixVersions.stable;
}
