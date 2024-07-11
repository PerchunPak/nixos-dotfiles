{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };

      settings = {
        pickers.find_files.hidden = true;
        pickers.git_files.hidden = true;
        pickers.live_grep.hidden = true;
      };

      keymaps = {
        # See `:help telescope.builtin`
        "<leader>sh" = {
          action = "help_tags";
          options.desc = "[S]earch [H]elp";
        };
        "<leader>sk" = {
          action = "keymaps";
          options.desc = "[S]earch [K]eymaps";
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
    };
    extraConfigLua = # lua
      ''
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>/", function()
          builtin.current_buffer_fuzzy_find({ previewer = false })
        end, { desc = "[/] Fuzzily search in current file" })

        vim.keymap.set("n", "<leader>s/", function()
          builtin.live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          })
        end, { desc = "[S]earch [/] in Open Files" })

        vim.keymap.set("n", "<leader>s/", function()
          builtin.live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          })
        end, { desc = "[S]earch [/] in Open Files" })

        -- Firstly try searching in Git files, but if it crashes
        -- (e.g. if it is not a Git repository), fallback to `find_files`
        vim.keymap.set("n", "<leader>sf", function()
          if pcall(builtin.git_files) then
          else
            builtin.find_files()
          end
        end, { desc = "[S]earch [F]iles" })
      '';
  };
}
