{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    python312
    python312Packages.black
    ruff
    poetry # TODO impermanence
  ];
}
