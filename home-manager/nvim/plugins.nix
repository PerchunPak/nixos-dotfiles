{
  pkgs,
  inputs,
  ...
}: let
  nixvimHelpers = inputs.nixvim.lib.x86_64-linux.helpers;
in {
  programs.nixvim = {
    plugins = {
      comment.enable = true;
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
        };
      };
      which-key.enable = true;
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
      };
      fidget = {
        enable = true; # bottom left notifications
        notification.window.winblend = 0;
      };
      conform-nvim = {
        enable = true;
        # If you save file with syntax errors, it will stop you from
        # typing for next ~0.5s. Which is really annoying
        notifyOnError = false;

        # see https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
        formatOnSave = ''
          function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 500, lsp_fallback = true }
          end
        '';
        # WARN Do not forget to add these to `programs.nixvim.extraPackages` in default.nix
        formattersByFt = {
          nix = ["alejandra"];
          lua = ["stylua"];
          python = ["ruff_fix" "ruff_format"];
          javascript = ["prettierd"];
          "*" = ["codespell" "trim_whitespace"];
        };
      };
      # LSP
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          pylsp = {
            enable = true;
            settings.plugins = {
              black = {
                enabled = true;
                line_length = 120;
              };
              isort.enabled = true;
              rope.enabled = true;
              # rope_autoimport.enabled = true; # Isn't it already enabled in Jedi?
              ruff.enabled = true;
            };
          };
          yamlls.enable = true;
          typos-lsp.enable = true;
        };
      };
      # Autocompletion
      cmp = {
        enable = true;
        settings = {
          options = {
            completion.completeopt = "menu,menuone,noinsert";
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "fish";} # idk what it does, it is here because I use fish
          ];
        };
      };
      # Snippet Engine & its associated nvim-cmp source
      luasnip.enable = true;

      # Highlight todo, notes, etc in comments
      todo-comments.enable = true;
      # Collection of various small independent plugins/modules
      mini = {
        enable = true;
        modules = {
          # Better Around/Inside textobjects
          #
          # Examples:
          #  - va)  - [V]isually select [A]round [)]paren
          #  - yinq - [Y]ank [I]nside [N]ext [']quote
          #  - ci'  - [C]hange [I]nside [']quote
          ai = {
            n_lines = 500;
          };
          # Add/delete/replace surroundings (brackets, quotes, etc.)
          #
          # - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
          # - sd'   - [S]urround [D]elete [']quotes
          # - sr)'  - [S]urround [R]eplace [)] [']
          surround = {};
          # Simple and easy statusline.
          #  You could remove this setup call if you don't like it,
          #  and try some other statusline plugin
          statusline.use_icons = true;
          indentscope = {
            draw = {
              delay = 0;
              animation = nixvimHelpers.mkRaw "function() return 0 end"; # disable animation
              priority = 2;
            };
            options = {
              try_as_border = true;
              border = "top";
            };
            symbol = "▎";
          };
          basics = {};
          bracketed = {};
          comment = {};
        };
      };
      # Highlight, edit, and navigate code
      treesitter = {
        enable = true;
        indent = true;
        # There are additional nvim-treesitter modules that you can use to interact
        # with nvim-treesitter. You should go explore a few and see what interests you:
        #
        #    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        #    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        #    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      };
      transparent.enable = true;
      nvim-autopairs.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          shade_terminals = false;
          terminal_mappings = true;
          # for system reproducibility reasons
          persist_size = false;
          persist_mode = false;
        };
      };
      alpha = {
        enable = true;
        theme = "startify";
      };
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            smart_indent_cap = false;
            priority = 1;
          };
          scope = {
            show_start = false;
            show_end = false;
          };
        };
      };
      rainbow-delimiters.enable = true;
      undotree = {
        enable = true;
        settings = {
          DiffpanelHeight = 0;
          SetFocusWhenToggle = 1;
        };
      };
    };
    extraPlugins = with pkgs.unstable.vimPlugins; [
      vim-sleuth # Detect tabstop and shiftwidth automatically
      nvim-web-devicons # Useful for getting pretty icons, but requires a Nerd Font.
      neodev-nvim # used for completion, annotations and signatures of Neovim apis
      lazygit-nvim
    ];
  };
}
