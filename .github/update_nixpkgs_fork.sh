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
  `: # variety: 0.9.0-b1 -> 0.9.2` \
  https://github.com/NixOS/nixpkgs/pull/585616 \
  `: # tabiew: add zstd & sqlcipher to buildInputs` \
  https://github.com/NixOS/nixpkgs/pull/585747 \
  `: # zellij-unwrapped: add missing runtime libs` \
  https://github.com/NixOS/nixpkgs/pull/588966 \
  `: # equibop: 3.2.2 -> 3.3.4` \
  https://github.com/NixOS/nixpkgs/pull/589090

nix flake update nixpkgs
