#!/usr/bin/env bash
set -ex

system=$(nix-instantiate --eval --raw --expr 'builtins.currentSystem')
nixpkgs_rev=$(
  nix flake metadata --json \
  | jq -er '.locks.nodes."nixpkgs-upstream".locked.rev'
)
nix run ".#pkgs.$system.nixpkgs.gh-cherry-pick" -- \
  --target PerchunPak/nixpkgs@patched \
  --first-hard-reset-to "NixOS/nixpkgs/$nixpkgs_rev" \
  PerchunPak/nixpkgs@zellij-plugins \
  PerchunPak/nixpkgs@wayle \
  PerchunPak/nixpkgs@actual \
  PerchunPak/nixpkgs@gh-cherry-pick-init

nix flake update nixpkgs
