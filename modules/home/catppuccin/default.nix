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
    hyprcursor.enable = true;
  };
}
