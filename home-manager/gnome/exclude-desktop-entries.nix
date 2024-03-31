{lib, ...}: let
  toProperAttrs = names:
    builtins.listToAttrs
    (lib.forEach names (name: {
      inherit name;
      value = {
        inherit name;
        exec = "";
        noDisplay = true;
      };
    }));
in {
  xdg.desktopEntries = toProperAttrs [
    "fish"
    "htop"
    # "kitty-open"
    # "kitty"
    "nvim"
    "peazip-add-to-7z"
    "peazip-add-to-archive"
    "peazip-add-to-brotli"
    "peazip-add-to-bzip2"
    "peazip-add-to-gzip"
    "peazip-add-to-pea"
    "peazip-add-to-tar"
    "peazip-add-to-wim"
    "peazip-add-to-xz"
    "peazip-add-to-zip"
    "peazip-add-to-zpaq"
    "peazip-add-to-zstd"
    "peazip-convert"
    "peazip-extract-here"
    "peazip-extract-smart"
    "peazip-extract"
    "peazip-open"
  ];
}
