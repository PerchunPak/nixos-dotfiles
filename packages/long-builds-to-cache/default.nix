{
  inputs,
  pkgs,
}:
pkgs.buildEnv {
  name = "long-builds-to-cache";
  paths =
    (with pkgs; [ lix ])
    ++ (with inputs.catppuccin.packages.${pkgs.system}; [
      whiskers
      cursors
    ])
    ++ (with inputs.nix-index-database.packages.x86_64-linux; [ comma-with-db ]);
  ignoreCollisions = true;
}
