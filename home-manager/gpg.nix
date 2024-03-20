{
  pkgs,
  config,
  ...
}: {
  programs.gpg.enable = true;

  age.secrets.gpg-key.file = ../secrets/gpg-key.age;
  my.setup-stuff.gpg-key = {
    enable = true;
    command = let
      replace = builtins.replaceStrings ["$XDG_RUNTIME_DIR"] ["\${XDG_RUNTIME_DIR}"];
    in
      replace "${pkgs.gnupg}/bin/gpg --batch --import ${config.age.secrets.gpg-key.path}";
  };
}
