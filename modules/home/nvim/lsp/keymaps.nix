{
  my.nvim.keymaps = [
    # Diagnostic keymaps
    [
      "n"
      "[d"
      "vim.diagnostic.goto_prev"
      {
        lua = true;
        options.desc = "Go to previous [D]iagnostic message";
      }
    ]
    [
      "n"
      "]d"
      "vim.diagnostic.goto_next"
      {
        lua = true;
        options.desc = "Go to next [D]iagnostic message";
      }
    ]
    [
      "n"
      "<leader>e"
      "vim.diagnostic.open_float"
      {
        lua = true;
        options.desc = "Show diagnostic [E]rror messages";
      }
    ]
    [
      "n"
      "<leader>q"
      "vim.diagnostic.setloclist"
      {
        lua = true;
        options.desc = "Open diagnostic [Q]uickfix list";
      }
    ]
    # Opens a popup that displays documentation about the word under your cursor
    #  See `:help K` for why this keymap
    [
      "n"
      "K"
      "vim.lsp.buf.hover"
      {
        lua = true;
        options.desc = "Hover Documentation";
      }
    ]
    # WARN: This is not Goto Definition, this is Goto Declaration.
    #  For example, in C this would take you to the header
    [
      "n"
      "gD"
      "vim.lsp.buf.declaration"
      {
        lua = true;
        options.desc = "[G]oto [D]eclaration";
      }
    ]
    # Execute a code action, usually your cursor needs to be on top of an error
    # or a suggestion from your LSP for this to activate.
    [
      "n"
      "<leader>ca"
      "vim.lsp.buf.code_action"
      {
        lua = true;
        options.desc = "[C]ode [A]ction";
      }
    ]
    # Rename the variable under your cursor
    #  Most Language Servers support renaming across files, etc.
    [
      "n"
      "<leader>rn"
      "vim.lsp.buf.rename"
      {
        lua = true;
        options.desc = "[R]e[n]ame";
      }
    ]
  ];
}
