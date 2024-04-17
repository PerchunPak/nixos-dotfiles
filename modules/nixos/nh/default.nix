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
    # hacky way to say /home/perchun/dotfiles without hardcoding /home/perchun
    flake = /. + config.home-manager.users.perchun.home.homeDirectory + "/dotfiles";
    clean = {
      enable = true;
      extraArgs = "--keep 10 --keep-since 1d";
    };
  };

  # related great packages
  environment.systemPackages = with pkgs.unstable; [
    nix-output-monitor
    nvd
  ];
}
