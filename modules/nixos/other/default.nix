{ pkgs, ... }:
{
  environment.defaultPackages = with pkgs; [ ];

  programs = {
    trippy.enable = true;
  };
}
