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
  `: # zellijPlugins: init` \
  https://github.com/NixOS/nixpkgs/pull/511825 \
  `: # actual-client: init` \
  https://github.com/NixOS/nixpkgs/pull/506686 \
  `: # equibop: 2.1.9 -> 2.2.0` \
  https://github.com/NixOS/nixpkgs/pull/514209 \
  `: # updates cyclopts, so it builds` \
  https://github.com/NixOS/nixpkgs/pull/514199 \
  `: # wayle: 0.2.3 -> 0.3.0` \
  https://github.com/NixOS/nixpkgs/pull/521497

nix flake update nixpkgs
