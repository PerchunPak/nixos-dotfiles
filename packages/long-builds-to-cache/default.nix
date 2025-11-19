{
  inputs,
  pkgs,
}:
pkgs.buildEnv {
  name = "long-builds-to-cache";
  paths =
    (with pkgs; [
      lix
      obs-studio
      meld
    ])
    ++ (with inputs.catppuccin.packages.${pkgs.system}; [
      whiskers
      cursors
    ]);
  ignoreCollisions = true;
}
