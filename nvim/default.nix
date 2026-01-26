inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
{
  imports = [ wlib.wrapperModules.neovim ];

  options.isTest = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = {
    # The makeWrapper options are available
    extraPackages = with pkgs; [
      fd
      imagemagick
      pandoc
      ripgrep
      stdenv.cc.cc
      universal-ctags
      wl-clipboard

      # language servers
      astro-language-server
      basedpyright
      bash-language-server
      gleam
      graphql-language-service-cli
      harper
      lua-language-server
      marksman
      nixd
      rust-analyzer
      svelte-language-server
      tailwindcss-language-server
      typescript-language-server
      typos-lsp
      yaml-language-server

      # formatting
      black
      codespell
      gawk # trim_whitespace
      nixfmt
      prettierd
      rustfmt
      stylua
    ];

    specs = with pkgs.vimPlugins; {
      general = [
        lze
        lzextras
        friendly-snippets
      ];
      lazy = {
        lazy = true;
        after = [ "general" ];
        data = [
          blink-cmp
          catppuccin-nvim
          conform-nvim
          flash-nvim
          gitsigns-nvim
          indent-blankline-nvim
          kulala-nvim
          lazydev-nvim
          luvit-meta
          mini-nvim
          nvim-lspconfig
          nvim-treesitter-context
          nvim-treesitter.withAllGrammars
          oil-nvim
          otter-nvim
          snacks-nvim
          todo-comments-nvim
          toggleterm-nvim
          undotree
          vim-sleuth
          which-key-nvim

          # debug
          nvim-dap
          nvim-dap-ui
          nvim-dap-python
        ];
      };
    };

    # These specMods are modules which modify your specs in specs
    # you can override defaults, or make your own options.
    # specMods =
    #   { parentSpec, ... }:
    #   {
    #     collateGrammars = lib.mkDefault (parentSpec.collateGrammars or true);
    #   };
    # or, if you dont care about propagating parent values:
    # specMods.collateGrammars = lib.mkDefault true;

    hosts = {
      python3 = {
        nvim-host.enable = true;
        withPackages =
          pyPkgs: with pyPkgs; [
            python-lsp-server
            python-lsp-ruff
          ];
      };
      perl.nvim-host.enable = false;
      node.nvim-host.enable = false;
      ruby.nvim-host.enable = false;
    };

    binName = if !config.isTest then "nvim" else "testNvim";
    settings = {
      aliases = lib.mkIf (!config.isTest) [ "v" ];
      dont_link = config.isTest;
      config_directory = if config.isTest then "/home/perchun/dotfiles/nvim" else ./.;

      nixpkgs-path = "${inputs.nixpkgs}";
    };
  };
}
