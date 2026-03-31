#!/usr/bin/env bash
set -ex

nix flake update gh-cherry-pick

nixpkgs_rev=$(
  nix flake metadata --json \
  | jq -er '.locks.nodes."nixpkgs-upstream".locked.rev'
)
nix run .#gh-cherry-pick -- \
  --target PerchunPak/nixpkgs@patched \
  --first-hard-reset-to "NixOS/nixpkgs/$nixpkgs_rev" \
  PerchunPak/nixpkgs@zellij-plugins \
  PerchunPak/nixpkgs@wayle

nix flake update nixpkgs
