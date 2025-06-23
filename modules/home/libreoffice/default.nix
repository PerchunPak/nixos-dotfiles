{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    hunspell
    hunspellDicts.en_US-large
    hunspellDicts.cs_CZ
    hunspellDicts.uk_UA
    hunspellDicts.ru_RU
  ];
}
