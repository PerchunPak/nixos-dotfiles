{ pkgs, lib, ... }:
{
  home = {
    username = "perchun";
    homeDirectory = "/home/perchun";
  };

  my = {
    setup-stuff.backlight.command = "${lib.getExe pkgs.brightnessctl} s 40%";
    gaming = {
      # additional-games = with pkgs; [ xonotic ];
      minecraft.enable = false;
      satisfactory.enable = false;
    };
  };

  # `allowUnfree` for experimental nix commands
  xdg.enable = true;
  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
