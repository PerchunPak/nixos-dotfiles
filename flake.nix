{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "github:PerchunPak/nixpkgs/patched";
    nixpkgs-upstream.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # pkgsCross.wasi32.buildPackages.rustc: fix build
    nixpkgs-patch-10.url = "https://github.com/PerchunPak/nixpkgs/commit/aa2356dc65ff1b5798a2453f764dae4f706bc5e0.diff?full_index=1";
    nixpkgs-patch-10.flake = false;
    # zellij: rename package file name
    nixpkgs-patch-11.url = "https://github.com/PerchunPak/nixpkgs/commit/5b42d84065933a04fc9b0b36704bdcae6ca01bc0.diff?full_index=1";
    nixpkgs-patch-11.flake = false;
    # zellijPlugins: init
    nixpkgs-patch-12.url = "https://github.com/PerchunPak/nixpkgs/commit/241fd794077b0b605507c5028d6c46d1f52075fe.diff?full_index=1";
    nixpkgs-patch-12.flake = false;
    # wayle: init at 0-unstable-2026-03-17
    nixpkgs-patch-20.url = "https://github.com/PerchunPak/nixpkgs/commit/e74327a46103e9b01f2951b8cdb4924ecb704465.diff?full_index=1";
    nixpkgs-patch-20.flake = false;

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
      url = "github:snowfallorg/lib?rev=e66423e29b722122f878cd4f332ed656fdb3dec4";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils-plus.follows = "flake-utils-plus";
    };
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus?rev=14d3fa54bbb4d61ce0128793a529e57bf70ac182";

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
    ctp-trippy = {
      url = "github:PerchunPak/ctp-trippy";
      flake = false;
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
            "claude-code"
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

      channels.nixpkgs.patches = [
        # (
        #   pkgs:
        #   pkgs.fetchpatch {
        #     url = "https://github.com/NixOS/nixpkgs/pull/481145.diff?full_index=1";
        #     hash = "sha256-N/uyTaIiD4E9kXhaJWi8+piHW/7kvL+yyeOPL98BagQ=";
        #   }
        # )
      ];

      overlays = with inputs; [
      ];

      systems.modules.nixos = with inputs; [ disko.nixosModules.default ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt;
      };
    };
}
