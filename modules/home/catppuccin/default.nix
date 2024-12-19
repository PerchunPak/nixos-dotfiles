{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  catppuccin = {
    enable = true;
    accent = "maroon";
    flavor = "mocha";

    cursors = {
      enable = true;
      accent = "dark";
    };
    gtk.icon.enable = false;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
  };
}
