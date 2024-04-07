# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules.setup-stuff

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./nvim
    ./gnome
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./other.nix
    ./secrets.nix
    ./fish
    ./kitty.nix
    ./impermanence.nix
    ./firefox.nix
    ./gaming.nix
    ./python.nix
    ./qbittorrent
    ./neofetch
    ./github-cli.nix
    ./variety
    ./vesktop
    ./catppuccin.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = outputs.overlays.all;
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "perchun";
    homeDirectory = "/home/perchun";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # `allowUnfree` for experimental nix commands
  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  programs.home-manager.enable = true;
  xdg.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
