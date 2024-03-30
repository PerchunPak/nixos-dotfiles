{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin.flavour = "mocha";

  console.catppuccin.enable = true;
  boot.loader.grub.catppuccin.enable = true;
}
