{ lib, ... }:
{
  nix.settings = {
    substituters = lib.mkForce [
      "https://nixos-cache-proxy.cofob.dev"
      "https://nix-community.cachix.org"
      "https://perchunpak.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "perchunpak.cachix.org-1:iTR6t8bKHw9ut4Fr4/8A0bjM/X67hsdR0I3F/PCUY9w="
    ];
  };
}
