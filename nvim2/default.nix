{ pkgs, nixCats }:
let
  # get the nixCats library with the builder function (and everything else) in it
  utils = import nixCats;
  # path to your new .config/nvim
  luaPath = ./.;

  # see :help nixCats.flake.outputs.categories
  categoryDefinitions =
    {
      pkgs,
      settings,
      categories,
      extra,
      name,
      mkPlugin,
      ...
    }@packageDef:
    {
      # to define and use a new category, simply add a new list to a set here,
      # and later, you will include categoryname = true; in the set you
      # provide when you build the package using this builder function.
      # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

      # lspsAndRuntimeDeps:
      # this section is for dependencies that should be available
      # at RUN TIME for plugins. Will be available to PATH within neovim terminal
      # this includes LSPs
      lspsAndRuntimeDeps = {
        general = with pkgs; [
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
        ];
      };

      # This is for plugins that will load at startup without using packadd:
      startupPlugins = {
        general = with pkgs.vimPlugins; [
          lze
          lzextras
        ];
      };

      # not loaded automatically at startup.
      # use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        general = with pkgs.vimPlugins; [
          catppuccin-nvim
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
        ];
      };

      # shared libraries to be added to LD_LIBRARY_PATH
      # variable available to nvim runtime
      sharedLibraries = {
        general = with pkgs; [ ];
      };

      # environmentVariables:
      # this section is for environmentVariables that should be available
      # at RUN TIME for plugins. Will be available to path within neovim terminal
      environmentVariables = {
        test = {
          CATTESTVAR = "It worked!";
        };
      };

      # lists of the functions you would have passed to
      # python.withPackages or lua.withPackages

      # get the path to this python environment
      # in your lua config via
      # vim.g.python3_host_prog
      # or run from nvim terminal via :!<packagename>-python3
      python3.libraries = {
        general = (
          pyPkgs: with pyPkgs; [
            python-lsp-server
            python-lsp-ruff
          ]
        );
      };
      # populates $LUA_PATH and $LUA_CPATH
      extraLuaPackages = {
        test = [ (_: [ ]) ];
      };
    };

  # And then build a package with specific categories from above here:
  # All categories you wish to include must be marked true,
  # but false may be omitted.
  # This entire set is also passed to nixCats for querying within the lua.

  # see :help nixCats.flake.outputs.packageDefinitions
  packageDefinitions = {
    # These are the names of your packages
    # you can include as many as you wish.
    nvim2 =
      {
        pkgs,
        name,
        mkPlugin,
        ...
      }:
      {
        # they contain a settings set defined above
        # see :help nixCats.flake.outputs.settings
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;
          configDirName = "nvim2";
          # IMPORTANT:
          # your aliases may not conflict with your other packages.
          aliases = [ "v2" ];
          # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
        };
        # and a set of categories that you want
        categories = {
          general = true;
          test = true;
        };
        # anything else to pass and grab in lua with `nixCats.extra`
        extra = { };
      };
  };

  # We will build the one named nvim here and export that one.
  # you can change which package from packageDefinitions is built later
  # using package.override { name = "aDifferentPackage"; }
  defaultPackageName = "nvim2";

  # return our package!
in
utils.baseBuilder luaPath {
  inherit pkgs;
} categoryDefinitions packageDefinitions defaultPackageName
