{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  catppuccin = {
    enable = true;
    accent = "maroon";
    flavor = "mocha";
  };

  gtk.catppuccin.cursor.accent = "dark";
  gtk.catppuccin.icon.enable = false;
}
