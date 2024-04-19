{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.my.catppuccin;
  # https://github.com/catppuccin/nix/blob/main/modules/lib/default.nix#L24-L38
  # or permalink https://github.com/catppuccin/nix/blob/03b95cad3bbeb9913db6d89dc3f4fccc6c8fcbd4/modules/lib/default.nix#L24-L38
  accent = "maroon";
in {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  options = {
    my.catppuccin = {
      enable = lib.my.mkEnableByDefaultOption "auto-theming catppuccin";
    };
  };

  config = lib.mkIf cfg.enable {
    catppuccin.flavour = "mocha";

    programs.bat.catppuccin.enable = true;
    programs.fish.catppuccin.enable = true;

    gtk.catppuccin = {
      enable = true;
      inherit accent;
      cursor = {
        enable = true;
        accent = "dark";
      };
    };

    programs.kitty.catppuccin.enable = true;
    programs.lazygit.catppuccin = {
      enable = true;
      inherit accent;
    };
    programs.neovim.catppuccin.enable = true;
  };
}
