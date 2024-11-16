{ lib, ... }:
{
  nix.settings = {
    # Add cache for nix-community packages
    substituters = lib.mkForce [
      "https://nixos-cache-proxy.cofob.dev"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
