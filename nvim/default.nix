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
{ inputs, ... }:
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
  inherit
    (forEachSystem (
      system:
      let
        # see :help nixCats.flake.outputs.overlays
        # This overlay grabs all the inputs named in the format
        # `plugins-<pluginName>`
        # Once we add this overlay to our nixpkgs, we are able to
        # use `pkgs.neovimPlugins`, which is a set of our plugins.
        dependencyOverlays = # (import ./overlays inputs) ++
          [
            (utils.standardPluginOverlay inputs)
            # add any flake overlays here.
            (final: prev: {
              vimPlugins = prev.vimPlugins // {
                nvim-dbee = final.vimUtils.buildVimPlugin (
                  let
                    self = final.vimPlugins.nvim-dbee;
                    dbee-go = final.buildGoModule {
                      name = "nvim-dbee";
                      src = "${self.src}/dbee";
                      vendorHash = "sha256-U/3WZJ/+Bm0ghjeNUILsnlZnjIwk3ySaX3Rd4L9Z62A=";
                      buildInputs = [
                        final.arrow-cpp
                        final.duckdb
                      ];
                    };
                  in
                  {
                    dependencies = [ final.vimPlugins.nui-nvim ];

                    # nvim-dbee looks for the go binary in paths returned bu M.dir() and M.bin() defined in lua/dbee/install/init.lua
                    postPatch = ''
                      substituteInPlace lua/dbee/install/init.lua \
                        --replace-fail 'return vim.fn.stdpath("data") .. "/dbee/bin"' 'return "${dbee-go}/bin"'
                    '';

                    preFixup = ''
                      mkdir $target/bin
                      ln -s ${dbee-go}/bin/dbee $target/bin/dbee
                    '';

                    pname = "nvim-dbee";
                    version = "2024-07-26";
                    src = final.fetchFromGitHub {
                      owner = "kndndrj";
                      repo = "nvim-dbee";
                      tag = "v0.1.9";
                      sha256 = "10xplksglyd8af8q1cl2lxcpn52b766g87gva9fd3l66idxsds00";
                    };
                    meta.homepage = "https://github.com/kndndrj/nvim-dbee/";
                  }
                );
              };
            })
          ];
      in
      {
        inherit dependencyOverlays;
      }
    ))
    dependencyOverlays
    ;

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
            universal-ctags
            ripgrep
            fd
            stdenv.cc.cc
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
            cmp-path
            cmp_luasnip
            conform-nvim
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
  };
  inherit utils;
  inherit (utils) templates;
}
