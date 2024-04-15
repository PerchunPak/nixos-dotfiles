{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib?ref=pull/71/head";
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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    catppuccin.url = "github:catppuccin/nix?ref=pull/116/head";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        namespace = "my";
      };

      channels-config.allowUnfree = true;

      overlays = with inputs; [
        nur.overlay
      ];

      systems.modules.nixos = with inputs; [
        disko.nixosModules.default
        catppuccin.nixosModules.catppuccin
        impermanence.nixosModules.impermanence
      ];

      formatter = inputs.flake-utils.lib.eachDefaultSystemMap (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);
    };
}
