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
        ];
      };

      # This is for plugins that will load at startup without using packadd:
      startupPlugins = {
        general = with pkgs.vimPlugins; [
          lze
          lzextras
          friendly-snippets
        ];
      };

      # not loaded automatically at startup.
      # use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        general = with pkgs.vimPlugins; [
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
    neovim =
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
          configDirName = "nvim";
          # IMPORTANT:
          # your aliases may not conflict with your other packages.
          aliases = [
            "nvim"
            "v"
          ];
          # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          hosts.python3.enable = true;
        };
        # and a set of categories that you want
        categories = {
          general = true;
          test = true;
        };
        # anything else to pass and grab in lua with `nixCats.extra`
        extra = { };
      };

    testNvim =
      { pkgs, ... }:
      {
        settings = {
          aliases = [ "tv2" ];
          wrapRc = false;
        };
        categories.general = true;
        hosts.python3.enable = true;
      };
  };

  defaultPackageName = "neovim";

  nixCatsBuilder = utils.baseBuilder luaPath {
    inherit pkgs;
  } categoryDefinitions packageDefinitions;
  defaultPackage = nixCatsBuilder defaultPackageName;
in
# this will make a package out of each of the packageDefinitions defined above
# and set the default package to the one passed in here.
utils.mkAllPackages defaultPackage
