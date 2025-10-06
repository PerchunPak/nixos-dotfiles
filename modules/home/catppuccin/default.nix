{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

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
    mako.enable = false; # why is this even active
    eza.enable = false; # imo original colors are better
  };

  home.pointerCursor = {
    size = 32;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
  };
}
