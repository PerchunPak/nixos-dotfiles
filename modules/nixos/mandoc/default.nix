{
  # https://github.com/NixOS/nixpkgs/issues/513348
  documentation.man = {
    mandoc.enable = true;
    man-db.enable = false;
  };
}
