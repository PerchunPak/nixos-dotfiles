{
  config,
  inputs,
  ...
}: let
  # https://github.com/catppuccin/nix/blob/main/modules/lib/default.nix#L24-L38
  # or permalink https://github.com/catppuccin/nix/blob/03b95cad3bbeb9913db6d89dc3f4fccc6c8fcbd4/modules/lib/default.nix#L24-L38
  accent = "maroon";
in {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

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
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  programs.kitty.catppuccin.enable = true;
  programs.lazygit.catppuccin = {
    enable = true;
    inherit accent;
  };
  programs.neovim.catppuccin.enable = true;
}
