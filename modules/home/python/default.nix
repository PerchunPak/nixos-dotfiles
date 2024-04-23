{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python312
    python312Packages.black
    python312Packages.ipython
    ruff
    poetry
    pkgs.my.cruft
  ];

  my.persistence.directories = [
    ".local/share/pypoetry"
    ".cache/pypoetry"
  ];
}
