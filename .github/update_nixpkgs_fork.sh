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
  `: # kulala-core: init at 0.6.0; vimPlugins.kulala-nvim: 5.3.4 -> 6.1.0` \
  https://github.com/NixOS/nixpkgs/pull/523733 \
  `: # kulala-core: 0.6.0 -> 0.7.0; vimPlugins.kulala-nvim: 6.1.0 -> 6.2.0` \
  https://github.com/NixOS/nixpkgs/pull/524008 \
  `: # wayle: 0.3.0 -> 0.4.0` \
  https://github.com/NixOS/nixpkgs/pull/524011

nix flake update nixpkgs
