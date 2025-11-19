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
    ]);
  ignoreCollisions = true;
}
