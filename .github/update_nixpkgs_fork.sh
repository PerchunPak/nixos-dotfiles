#!/usr/bin/env bash
set -ex

system=$(nix-instantiate --eval --raw --expr 'builtins.currentSystem')
nixpkgs_rev=$(
  nix flake metadata --json \
  | jq -er '.locks.nodes."nixpkgs-upstream".locked.rev'
)
nix run ".#pkgs.$system.nixpkgs.ghcherry" -- \
  --target PerchunPak/nixpkgs@patched \
  --first-hard-reset-to "NixOS/nixpkgs/$nixpkgs_rev" \
  `: # actual-client: init` \
  https://github.com/NixOS/nixpkgs/pull/506686 \
  `: # wayle: 0.4.1 -> 0.6.0` \
  https://github.com/NixOS/nixpkgs/pull/526419

nix flake update nixpkgs
