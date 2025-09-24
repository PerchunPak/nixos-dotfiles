{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python313
    python313Packages.pip
    python313Packages.black
    python313Packages.ipython
    uv
    ruff
    cruft
  ];

  programs = {
    poetry = {
      enable = true;
      settings = {
        # use python 3.12 instead of what nixos installs poetry with (3.11)
        #
        # i wish there was a way to override poetry in that way, it could
        # be built on 3.12
        virtualenvs.prefer-active-python = true;
      };
    };
  };

  home.sessionVariables = {
    UV_LINK_MODE = "symlink";
  };

  my.persistence.directories = [
    ".local/share/pypoetry"
    ".local/share/uv"
    ".cache/pypoetry"
    ".cache/pre-commit"
    ".cache/uv"
  ];
}
