# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license
/*
  Call this file with:
  myNixCats = import ./path/to/this/dir { inherit inputs; };
  And the new variable myNixCats will contain all outputs of the normal flake format.
  You could put myNixCats.packages.${pkgs.system}.thepackagename in your packages list.
  You could install them with the module and reconfigure them too if you want.
  You should definitely re export them under packages.${system}.packagenames
  from your system flake so that you can still run it via nix run from anywhere.

  The following is just the outputs function from the flake template.
*/
{ inputs, origPkgs, ... }:
let
  inherit (inputs) nixpkgs; # <-- nixpkgs = inputs.nixpkgsSomething;
  inherit (inputs.nixCats) utils;
  luaPath = "${./.}";
  forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
  # the following extra_pkg_config contains any values
  # which you want to pass to the config set of nixpkgs
  # import nixpkgs { config = extra_pkg_config; inherit system; }
  # will not apply to module imports
  # as that will have your system values
  extra_pkg_config = {
    # allowUnfree = true;
  };
  dependencyOverlays = [ (utils.standardPluginOverlay inputs) ] ++ origPkgs.overlays;

  categoryDefinitions =
    {
      pkgs,
      settings,
      categories,
      name,
      ...
    }@packageDef:
    {
      # @dependencies
      lspsAndRuntimeDeps = {
        general =
          with pkgs;
          [
            fd
            pandoc
            ripgrep
            stdenv.cc.cc
            universal-ctags
            wl-clipboard

            # language servers
            basedpyright
            bash-language-server
            gleam
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
            nixfmt-rfc-style
            prettierd
            rustfmt
            stylua
          ]
          ++ (with python3Packages; [
            debugpy
            basedpyright
          ]);
      };

      # @plugins
      startupPlugins =
        with pkgs.vimPlugins;
        # these are custom plugins, defined as inputs in flake and prefixed with `plugins-`
        with pkgs.neovimPlugins;
        {
          general = [
            alpha-nvim
            catppuccin-nvim
            cmp-nvim-lsp
            cmp-nvim-lsp-signature-help
            cmp-path
            cmp_luasnip
            conform-nvim
            devdocs-nvim
            fidget-nvim
            flash-nvim
            friendly-snippets
            gitsigns-nvim
            indent-blankline-nvim
            lazy-nvim
            lazydev-nvim
            lazygit-nvim
            luasnip
            luvit-meta
            mini-nvim
            nvim-autopairs
            nvim-cmp
            nvim-dbee
            nvim-lspconfig
            nvim-treesitter.withAllGrammars
            nvim-web-devicons
            oil-nvim
            otter-nvim
            plenary-nvim
            snacks-nvim
            telescope-fzf-native-nvim
            telescope-nvim
            telescope-ui-select-nvim
            todo-comments-nvim
            toggleterm-nvim
            undotree
            vim-fugitive
            vim-sleuth
            which-key-nvim

            # debug
            nvim-dap
            nvim-dap-ui
            nvim-nio
            nvim-dap-python
          ];
        };

      environmentVariables = { };

      # lists of the functions you would have passed to
      # python.withPackages or lua.withPackages

      # get the path to this python environment
      # in your lua config via
      # vim.g.python3_host_prog
      # or run from nvim terminal via :!<packagename>-python3
      extraPython3Packages = {
        general = [
          (
            pyPkgs: with pyPkgs; [
              python-lsp-server
              python-lsp-ruff
            ]
          )
        ];
      };
      # populates $LUA_PATH and $LUA_CPATH
      extraLuaPackages = {
        general = [ (_: [ ]) ];
      };

    };

  packageDefinitions = {
    nixCats =
      { pkgs, ... }:
      {
        # they contain a settings set defined above
        # see :help nixCats.flake.outputs.settings
        settings = {
          # IMPORTANT:
          # your alias may not conflict with your other packages.
          aliases = [
            "v"
            "vim"
            "nvim"
          ];

          withRuby = false;
          withPython3 = true;
          withNodeJs = false;
          withPerl = false;

          wrapRc = true;
        };
        categories.general = true;
      };
    # nvim which loads configuration from ~/.config/nvim, instead
    # of the store
    testNvim =
      { pkgs, ... }:
      {
        settings = {
          aliases = [ "tnvim" ];

          withRuby = false;
          withPython3 = true;
          withNodeJs = false;
          withPerl = false;

          wrapRc = false;
        };
        categories.general = true;
      };
  };
  # In this section, the main thing you will need to do is change the default package name
  # to the name of the packageDefinitions entry you wish to use as the default.
  defaultPackageName = "nixCats";
in
# see :help nixCats.flake.outputs.exports
forEachSystem (
  system:
  let
    nixCatsBuilder = utils.baseBuilder luaPath {
      inherit
        system
        dependencyOverlays
        extra_pkg_config
        nixpkgs
        ;
    } categoryDefinitions packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
  in
  {
    # this will make a package out of each of the packageDefinitions defined above
    # and set the default package to the one passed in here.
    packages = utils.mkAllWithDefault defaultPackage;
  }
)
// {
  # this will make an overlay out of each of the packageDefinitions defined above
  # and set the default overlay to the one named here.
  overlays = utils.makeOverlays luaPath {
    # we pass in the things to make a pkgs variable to build nvim with later
    inherit nixpkgs dependencyOverlays extra_pkg_config;
    # and also our categoryDefinitions
  } categoryDefinitions packageDefinitions defaultPackageName;

  # we also export a nixos module to allow reconfiguration from configuration.nix
  nixosModules.default = utils.mkNixosModules {
    inherit
      defaultPackageName
      dependencyOverlays
      luaPath
      categoryDefinitions
      packageDefinitions
      extra_pkg_config
      nixpkgs
      ;
    moduleNamespace = [ defaultPackageName ];
  };
  # and the same for home manager
  homeModule = utils.mkHomeModules {
    inherit
      defaultPackageName
      dependencyOverlays
      luaPath
      categoryDefinitions
      packageDefinitions
      extra_pkg_config
      nixpkgs
      ;
    moduleNamespace = [ defaultPackageName ];
  };
  inherit utils;
  inherit (utils) templates;
}
