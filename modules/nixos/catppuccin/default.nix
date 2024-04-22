{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavour = "mocha";
  };
}
