{
  pkgs,
  nixosConfig,
  lib,
  ...
}:
{
  home.packages = lib.mkIf nixosConfig.my.gui.enable (
    with pkgs;
    [
      libreoffice
      hunspell
      hunspellDicts.en_US-large
      hunspellDicts.cs_CZ
      hunspellDicts.uk_UA
      hunspellDicts.ru_RU
    ]
  );
}
