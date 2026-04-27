{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "github:PerchunPak/nixpkgs/patched";
    nixpkgs-upstream.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # my icons and other binary files I need
    storage = {
      url = "github:PerchunPak/storage";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rycee-nur = {
      url = "gitlab:rycee/nur-expressions";
      flake = false;
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-diff-rs = {
      url = "github:Mic92/nix-diff-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gh-cherry-pick = {
      url = "github:PerchunPak/gh-cherry-pick";
      flake = false;
    };
    wayle = {
      url = "github:wayle-rs/wayle";
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

      channels-config = {
        cudaSupport = true;
        allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "7zz"
            "nvidia-x11"
            "steam"
            "steam-original"
            "steam-run"
            "steam-unwrapped"
            "zerotierone"
            # Firefox extensions
            "enhancer-for-youtube"
            "grammarly"
            "languagetool"
            "limit-limit-distracting-sites"
            # cuda
            "cuda_cccl"
            "cuda_cudart"
            "cuda_nvcc"
            "libcublas"
            "libcufft"
            "libnpp"
          ];
      };

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt;
      };
    };
}
