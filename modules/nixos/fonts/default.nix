{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      meslo-lgs-nf
      fantasque-sans-mono
    ];
  };
}
