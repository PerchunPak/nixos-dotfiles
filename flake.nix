{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    catppuccin.url = "github:catppuccin/nix";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim
    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugins-luvit-meta = {
      url = "github:Bilal2453/luvit-meta";
      flake = false;
    };
    plugins-ranger-nvim = {
      url = "github:kelly-lin/ranger.nvim";
      flake = false;
    };
  };

  outputs =
    inputs:
    let
      lib = inputs.nixpkgs.lib;
    in
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        namespace = "my";
      };

      channels-config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "steam"
          "steam-original"
          "steam-run"
          "zerotierone"
          "zoom"
          # Firefox extensions
          "enhancer-for-youtube"
          "grammarly"
          "languagetool"
          "limit-limit-distracting-sites"
        ];

      overlays = with inputs; [
        nur.overlay
        lix-module.overlays.default
      ];

      systems.modules.nixos = with inputs; [ disko.nixosModules.default ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-rfc-style;
        nixCats = import ./nvim { inherit inputs; };
      };
    };
}
