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
    user.password = "$y$j9T$MOnKRLa06LS3z.zByavxg0$rqF5HHow3ZgcPJniHR7uu4aC64Kqtke4vE/SZiWVuv7";
  };

  wsl.enable = true;
  wsl.defaultUser = "perchun";
  wsl.interop.includePath = false;

  # on my desktop, impermanence clears it
  boot.tmp.cleanOnBoot = true;
}
