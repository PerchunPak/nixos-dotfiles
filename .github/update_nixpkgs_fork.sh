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
  PerchunPak/nixpkgs@actual \
  PerchunPak/nixpkgs@equibop-2.2.0 \
  `: # updates cyclopts, so gh-cherry-pick builds` \
  PerchunPak/nixpkgs/a4ba4b34b029face2600564e3b6e130eec4e91cf

nix flake update nixpkgs
