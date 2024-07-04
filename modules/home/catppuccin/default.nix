{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  catppuccin = {
    enable = true;
    pointerCursor.enable = true;
    accent = "maroon";
    flavor = "mocha";
  };

  gtk.catppuccin.icon.enable = false;
  catppuccin.pointerCursor.accent = "dark";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
  };
}
