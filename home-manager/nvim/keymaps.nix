{
  programs.nixvim = {
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

      {
        mode = "n";
        key = "<leader>g";
        action = ":LazyGit<CR>";
        options = {desc = "Open [G]it";};
      }

      {
        mode = "n";
        key = "<leader>u";
        action = ":UndotreeToggle<CR>";
        options = {desc = "Open [U]ndo tree";};
      }
    ];
    plugins = {
      which-key.registrations = {
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
      telescope.keymaps = {
        # See `:help telescope.builtin`
        "<leader>sh" = {
          action = "help_tags";
          options.desc = "[S]earch [H]elp";
        };
        "<leader>sk" = {
          action = "keymaps";
          options.desc = "[S]earch [K]eymaps";
        };
        "<leader>sf" = {
          action = "find_files";
          options.desc = "[S]earch [F]iles";
        };
        "<leader>ss" = {
          action = "builtin";
          options.desc = "[S]earch [S]elect Telescope";
        };
        "<leader>sw" = {
          action = "grep_string";
          options.desc = "[S]earch current [W]ord";
        };
        "<leader>sg" = {
          action = "live_grep";
          options.desc = "[S]earch by [G]rep";
        };
        "<leader>sd" = {
          action = "diagnostics";
          options.desc = "[S]earch [D]iagnostics";
        };
        "<leader>sr" = {
          action = "resume";
          options.desc = "[S]earch [R]esume";
        };
        "<leader>s." = {
          action = "oldfiles";
          options.desc = "[S]earch Recent Files (\".\" for repeat)";
        };
        "<leader><leader>" = {
          action = "buffers";
          options.desc = "[ ] Find existing buffers";
        };
        #  Jump to the definition of the word under your cursor.
        #   This is where a variable was first declared, or where a function is defined, etc.
        #   To jump back, press <C-t>.
        "gd" = {
          action = "lsp_definitions";
          options.desc = "[G]oto [D]efinition";
        };
        # Find references for the word under your cursor.
        "gr" = {
          action = "lsp_references";
          options.desc = "[G]oto [R]eferences";
        };
        # Jump to the implementation of the word under your cursor.
        #  Useful when your language has ways of declaring types without an actual implementation.
        "gI" = {
          action = "lsp_implementations";
          options.desc = "[G]oto [I]mplementation";
        };
        # Jump to the type of the word under your cursor.
        #  Useful when you're not sure what type a variable is and you want to see
        #  the definition of its *type*, not where it was *defined*.
        "<leader>D" = {
          action = "lsp_type_definitions";
          options.desc = "Type [D]efinition";
        };
        # Fuzzy find all the symbols in your current document.
        #  Symbols are things like variables, functions, types, etc.
        "<leader>ds" = {
          action = "lsp_document_symbols";
          options.desc = "[D]ocument [S]symbols";
        };
        # Fuzzy find all the symbols in your current workspace
        #  Similar to document symbols, except searches over your whole project.
        "<leader>ws" = {
          action = "lsp_dynamic_workspace_symbols";
          options.desc = "[W]orkspace [S]symbols";
        };
      };
      # For an understanding of why these mappings were
      # chosen, you will need to read `:help ins-completion`
      cmp.settings.options.mapping = {
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
      toggleterm.openMapping = "<c-\\>";
    };
  };
}
