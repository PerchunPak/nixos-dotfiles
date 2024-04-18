{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/nh.nix"
  ];

  programs.nh = {
    enable = true;
    package = pkgs.unstable.nh;
    flake = config.home-manager.users.perchun.home.homeDirectory + "/dotfiles";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 10 --keep-since 1d";
    };
  };

  # related great packages
  environment.systemPackages = with pkgs.unstable; [
    nix-output-monitor
    nvd
  ];
}
