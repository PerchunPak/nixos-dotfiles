# from https://functor.tokyo/blog/2018-10-01-japanese-on-nixos
{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # monospace
      nerd-fonts.meslo-lg
      nerd-fonts.jetbrains-mono
      # japanese
      ipafont
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "MesloLGS Nerd Font Regular"
          "JetBrainsMono Nerd Font"
          "IPAGothic"
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAPGothic"
        ];
        serif = [
          "DejaVu Serif"
          "IPAPMincho"
        ];
      };
    };
  };
}
