{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # overwrite nixpkgs with unstable branch
    ({...} @ args: (inputs.nixvim.homeManagerModules.nixvim (args // {pkgs = pkgs.unstable;})))
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      transparent_enabled = true;
    };
    options = {
      number = true;
      relativenumber = true;
      mouse = ""; # completely disable mouse
      showmode = false; # Don't show the mode, since it's already in status line
      clipboard = "unnamedplus"; # Sync clipboard between OS and Neovim.
      breakindent = true;
      undofile = true; # Save undo history
      # Case-insensitive searching UNLESS \C or capital in search
      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";
      # Decrease update time
      updatetime = 250;
      timeoutlen = 300;
      # Configure how new splits should be opened
      splitright = true;
      splitbelow = true;
      # Sets how neovim will display certain whitespace in the editor.
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      # Preview substitutions live, as you type!
      inccommand = "split";

      cursorline = true;
      # Minimal number of screen lines to keep above and below the cursor.
      scrolloff = 10;

      hlsearch = true;
    };
    keymaps = [
      # Set highlight on search, but clear on pressing <Esc> in normal mode
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      # Diagnostic keymaps
      {
        mode = "n";
        key = "[d";
        action = "vim.diagnostic.goto_prev";
        lua = true;
        options = {desc = "Go to previous [D]iagnostic message";};
      }
      {
        mode = "n";
        key = "]d";
        lua = true;
        action = "vim.diagnostic.goto_next";
        options = {desc = "Go to next [D]iagnostic message";};
      }
      {
        mode = "n";
        key = "<leader>e";
        lua = true;
        action = "vim.diagnostic.open_float";
        options = {desc = "Show diagnostic [E]rror messages";};
      }
      {
        mode = "n";
        key = "<leader>q";
        lua = true;
        action = "vim.diagnostic.setloclist";
        options = {desc = "Open diagnostic [Q]uickfix list";};
      }
      # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
      # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
      # is not what someone will guess without a bit more experience.
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {desc = "Exit terminal mode";};
      }
      # Disable arrow keys in normal mode
      {
        mode = "n";
        key = "<left>";
        action = "<cmd>echo \"Use h to move!!\"<CR>";
      }
      {
        mode = "n";
        key = "<right>";
        action = "<cmd>echo \"Use l to move!!\"<CR>";
      }
      {
        mode = "n";
        key = "<up>";
        action = "<cmd>echo \"Use k to move!!\"<CR>";
      }
      {
        mode = "n";
        key = "<down>";
        action = "<cmd>echo \"Use j to move!!\"<CR>";
      }
      # Keybinds to make split navigation easier.
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {desc = "Move focus to the left window";};
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {desc = "Move focus to the right window";};
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {desc = "Move focus to the lower window";};
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {desc = "Move focus to the upper window";};
      }
      # Opens a popup that displays documentation about the word under your cursor
      #  See `:help K` for why this keymap
      {
        mode = "n";
        key = "K";
        lua = true;
        action = "vim.lsp.buf.hover";
        options = {desc = "Hover Documentation";};
      }
      # WARN: This is not Goto Definition, this is Goto Declaration.
      #  For example, in C this would take you to the header
      {
        mode = "n";
        key = "gD";
        lua = true;
        action = "vim.lsp.buf.declaration";
        options = {desc = "[G]oto [D]eclaration";};
      }
      # Execute a code action, usually your cursor needs to be on top of an error
      # or a suggestion from your LSP for this to activate.
      {
        mode = "n";
        key = "<leader>ca";
        lua = true;
        action = "vim.lsp.buf.code_action";
        options = {desc = "[C]ode [A]ction";};
      }
      # Rename the variable under your cursor
      #  Most Language Servers support renaming across files, etc.
      {
        mode = "n";
        key = "<leader>rn";
        lua = true;
        action = "vim.lsp.buf.rename";
        options = {desc = "[R]e[n]ame";};
      }
    ];

    extraConfigLua = ''
      -- Highlight when yanking (copying) text
      --  Try it with `yap` in normal mode
      --  See `:help vim.highlight.on_yank()`
      vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
          vim.highlight.on_yank()
        end,
      })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    '';

    plugins = {
      transparent.enable = true;
      comment-nvim.enable = true;
      gitsigns = {
        enable = true;
        signs = {
          add = {text = "+";};
          change = {text = "~";};
          delete = {text = "_";};
          topdelete = {text = "‾";};
          changedelete = {text = "~";};
        };
      };
      which-key = {
        enable = true;
        registrations = {
          "<leader>c" = {
            name = "[C]ode";
            _ = "which_key_ignore";
          };
          "<leader>d" = {
            name = "[D]ocument";
            _ = "which_key_ignore";
          };
          "<leader>r" = {
            name = "[R]ename";
            _ = "which_key_ignore";
          };
          "<leader>s" = {
            name = "[S]earch";
            _ = "which_key_ignore";
          };
          "<leader>w" = {
            name = "[W]orkspace";
            _ = "which_key_ignore";
          };
        };
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
        keymaps = {
          # See `:help telescope.builtin`
          "<leader>sh" = {
            action = "help_tags";
            desc = "[S]earch [H]elp";
          };
          "<leader>sk" = {
            action = "keymaps";
            desc = "[S]earch [K]eymaps";
          };
          "<leader>sf" = {
            action = "find_files";
            desc = "[S]earch [F]iles";
          };
          "<leader>ss" = {
            action = "builtin";
            desc = "[S]earch [S]elect Telescope";
          };
          "<leader>sw" = {
            action = "grep_string";
            desc = "[S]earch current [W]ord";
          };
          "<leader>sg" = {
            action = "live_grep";
            desc = "[S]earch by [G]rep";
          };
          "<leader>sd" = {
            action = "diagnostics";
            desc = "[S]earch [D]iagnostics";
          };
          "<leader>sr" = {
            action = "resume";
            desc = "[S]earch [R]esume";
          };
          "<leader>s." = {
            action = "oldfiles";
            desc = "[S]earch Recent Files (\".\" for repeat)";
          };
          "<leader><leader>" = {
            action = "buffers";
            desc = "[ ] Find existing buffers";
          };
          #  Jump to the definition of the word under your cursor.
          #   This is where a variable was first declared, or where a function is defined, etc.
          #   To jump back, press <C-t>.
          "gd" = {
            action = "lsp_definitions";
            desc = "[G]oto [D]efinition";
          };
          # Find references for the word under your cursor.
          "gr" = {
            action = "lsp_references";
            desc = "[G]oto [R]eferences";
          };
          # Jump to the implementation of the word under your cursor.
          #  Useful when your language has ways of declaring types without an actual implementation.
          "gI" = {
            action = "lsp_implementations";
            desc = "[G]oto [I]mplementation";
          };
          # Jump to the type of the word under your cursor.
          #  Useful when you're not sure what type a variable is and you want to see
          #  the definition of its *type*, not where it was *defined*.
          "<leader>D" = {
            action = "lsp_type_definitions";
            desc = "Type [D]efinition";
          };
          # Fuzzy find all the symbols in your current document.
          #  Symbols are things like variables, functions, types, etc.
          "<leader>ds" = {
            action = "lsp_document_symbols";
            desc = "[D]ocument [S]ymbols";
          };
          # Fuzzy find all the symbols in your current workspace
          #  Similar to document symbols, except searches over your whole project.
          "<leader>ws" = {
            action = "lsp_dynamic_workspace_symbols";
            desc = "[W]orkspace [S]ymbols";
          };
        };
      };
      fidget.enable = true; # bottom left notifications
      conform-nvim = {
        enable = true;
        # notifyOnError = false; # why kickstarter has this off?
        formattersByFt = {
          lua = ["stylua"];
          # Conform will run multiple formatters sequentially
          python = ["isort" "black"];
          # Use a sub-list to run only the first available formatter
          javascript = [["prettierd" "prettier"]];
          # Use the "*" filetype to run formatters on all filetypes.
          "*" = ["codespell"];
          # Use the "_" filetype to run formatters on filetypes that don't
          # have other formatters configured.
          "_" = ["trim_whitespace"];
        };
      };
      # Autocompletion
      cmp = {
        enable = true;
        settings.options = {
          completion.completeopt = "menu,menuone,noinsert";
          # For an understanding of why these mappings were
          # chosen, you will need to read `:help ins-completion`
          mapping = {
            # Select the [n]ext item
            "<C-n>" = "cmp.mapping.select_next_item()";
            # Select the [p]revious item
            "<C-p>" = "cmp.mapping.select_prev_item()";

            # Accept ([y]es) the completion.
            #  This will auto-import if your LSP supports it.
            #  This will expand snippets if the LSP sent a snippet.
            "<C-y>" = "cmp.mapping.confirm { select = true }";

            # Manually trigger a completion from nvim-cmp.
            #  Generally you don't need this, because nvim-cmp will display
            #  completions whenever it has completion options available.
            "<C-Space>" = "cmp.mapping.complete {}";

            # Think of <c-l> as moving to the right of your snippet expansion.
            #  So if you have a snippet that's like:
            #  function $name($args)
            #    $body
            #  end
            #
            # <c-l> will move you to the right of each of the expansion locations.
            # <c-h> is similar, except moving you backwards.
            "<C-l>" = ''
              cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
                end
              end, { 'i', 's' })
            '';
            "<C-h>" = ''
              cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                end
              end, { 'i', 's' })
            '';
          };
        };
      };
      # Snippet Engine & its associated nvim-cmp source
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      # Adds other completion capabilities.
      #  nvim-cmp does not ship with all sources by default. They are split
      #  into multiple repos for maintenance purposes.
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      # idk what it does, it is here because I use fish
      cmp-fish.enable = true;

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
          statusline = {
            use_icons = true;
            # You can configure sections in the statusline by overriding their
            # default behavior. For example, here we set the section for
            # cursor location to LINE:COLUMN
            section_location = "%2l:%-2v";
          };
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
    };
    extraPlugins = with pkgs.unstable.vimPlugins; [
      vim-sleuth # Detect tabstop and shiftwidth automatically
      nvim-web-devicons # Useful for getting pretty icons, but requires a Nerd Font.
      neodev-nvim # used for completion, annotations and signatures of Neovim apis
    ];
  };
}
