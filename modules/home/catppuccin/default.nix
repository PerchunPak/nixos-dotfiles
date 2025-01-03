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
    wlogout.enable = false; # i like my config more
  };

  home.pointerCursor = {
    size = 32;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
  };
}
