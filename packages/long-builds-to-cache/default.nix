{
  linkFarmFromDrvs,
  inputs,
  pkgs,
  stdenv,
}:
let
  inherit (stdenv.hostPlatform) system;
  nix-index-packages = import "${inputs.nix-index-database}/default.nix" { inherit pkgs; };
in
linkFarmFromDrvs "long-builds-to-cache" (
  (with pkgs; [
    wayle
    zellij
    zellijPlugins.vim-zellij-navigator
  ])
  ++ [
    nix-index-packages.comma-with-db
  ]
  ++ (with inputs.catppuccin.packages.${system}; [
    whiskers
    cursors
  ])
)
