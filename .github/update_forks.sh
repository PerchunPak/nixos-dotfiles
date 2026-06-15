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
  https://github.com/NixOS/nixpkgs/pull/506686

impermanence_rev=$(
  nix flake metadata --json \
  | jq -er '.locks.nodes."impermanence-upstream".locked.rev'
)
nix run ".#pkgs.$system.nixpkgs.ghcherry" -- \
  --target PerchunPak/impermanence@patched \
  --first-hard-reset-to "NixOS/impermanence/$impermanence_rev" \
  `: # Don't auto import home-manager module` \
  PerchunPak/impermanence/57b3c603950a6f42691c495f2452d117c6461623

nix flake update nixpkgs impermanence
