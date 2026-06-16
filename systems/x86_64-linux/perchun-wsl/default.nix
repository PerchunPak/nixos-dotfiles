{ inputs, lib, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../../../manual-modules/impermanence-stub
  ];

  networking.hostName = "perchun-wsl";
  networking.networkmanager.enable = lib.mkForce false;

  my = {
    gui.enable = false;
    user.password = "$y$j9T$PQmCrgTV4zyANdfqVCGxW/$7zLGsLYwRicDOFiYPTrIvSC.l.fT82Q8pysYE8uIeZ8";
  };

  wsl.enable = true;
  wsl.defaultUser = "perchun";
  wsl.interop.includePath = false;
}
