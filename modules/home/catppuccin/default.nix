{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    accent = "maroon";
    flavour = "mocha";
  };

  gtk.catppuccin.cursor.accent = "dark";
}
