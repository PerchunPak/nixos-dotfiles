{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.gpg.enable = true;

  age.secrets.gpg-key.file = lib.my.toSecretFile "gpg-key";
  my.setup-stuff.gpg-key = {
    command = let
      replace = builtins.replaceStrings ["$XDG_RUNTIME_DIR"] ["\${XDG_RUNTIME_DIR}"];
    in
      replace "${pkgs.gnupg}/bin/gpg --batch --import ${config.age.secrets.gpg-key.path}";
  };
}
