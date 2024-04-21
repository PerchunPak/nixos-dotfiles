{
  config,
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = config.home-manager.users.perchun.home.homeDirectory + "/dotfiles";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 10 --keep-since 1d";
    };
  };

  # related great packages
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
