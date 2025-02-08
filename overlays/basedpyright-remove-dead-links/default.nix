{ ... }:
final: prev: {
  basedpyright = prev.basedpyright.overrideAttrs (old: {
    postInstall =
      old.postInstall
      + ''
        # Remove dangling symlinks created during installation (remove -delete to just see the files, or -print '%l\n' to see the target
        find -L $out -type l -print -delete
      '';
  });
}
