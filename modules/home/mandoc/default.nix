{
  # https://github.com/NixOS/nixpkgs/issues/513348
  programs.man = {
    mandoc.enable = true;
    man-db.enable = false;
  };
}
