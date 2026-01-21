{
  buildEnv,
  inputs,
  pkgs,
  system,
  lix,
}:
let
  nix-index-packages = import "${inputs.nix-index-database}/default.nix" { inherit pkgs; };
in
buildEnv {
  name = "long-builds-to-cache";
  paths = [
    lix
    nix-index-packages.comma-with-db
  ]
  ++ (with inputs.catppuccin.packages.${system}; [
    whiskers
    cursors
  ]);
  ignoreCollisions = true;
}
