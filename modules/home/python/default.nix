{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    python312
    python312Packages.black
    python312Packages.ipython
    ruff
    poetry
    pkgs.my.cruft
  ];
}
