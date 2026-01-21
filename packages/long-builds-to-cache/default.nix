{
  buildEnv,
  inputs,
  system,
  lix,
}:
buildEnv {
  name = "long-builds-to-cache";
  paths = [
    lix
  ]
  ++ (with inputs.catppuccin.packages.${system}; [
    whiskers
    cursors
  ])
  ++ (with inputs.nix-index-database.packages.${system}; [ comma-with-db ]);
  ignoreCollisions = true;
}
