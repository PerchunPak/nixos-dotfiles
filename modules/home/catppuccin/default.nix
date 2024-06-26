{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  catppuccin = {
    enable = true;
    accent = "maroon";
    flavor = "mocha";
  };

  gtk.catppuccin.icon.enable = false;
  catppuccin.pointerCursor.accent = "dark";
}
