{pkgs, ...}: {
  home = {
    username = "perchun";
    homeDirectory = "/home/perchun";
  };

  my = {
    gaming.additional-games = with pkgs; [xonotic];
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
