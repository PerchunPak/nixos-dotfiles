{
  my.nvim.keymaps = [
    # Diagnostic keymaps
    [
      "n"
      "[d"
      { __raw = "vim.diagnostic.goto_prev"; }
      { options.desc = "Go to previous [D]iagnostic message"; }
    ]
    [
      "n"
      "]d"
      { __raw = "vim.diagnostic.goto_next"; }
      { options.desc = "Go to next [D]iagnostic message"; }
    ]
    [
      "n"
      "<leader>e"
      { __raw = "vim.diagnostic.open_float"; }
      { options.desc = "Show diagnostic [E]rror messages"; }
    ]
    [
      "n"
      "<leader>q"
      { __raw = "vim.diagnostic.setloclist"; }
      { options.desc = "Open diagnostic [Q]uickfix list"; }
    ]
    # Opens a popup that displays documentation about the word under your cursor
    #  See `:help K` for why this keymap
    [
      "n"
      "K"
      { __raw = "vim.lsp.buf.hover"; }
      { options.desc = "Hover Documentation"; }
    ]
    # WARN: This is not Goto Definition, this is Goto Declaration.
    #  For example, in C this would take you to the header
    [
      "n"
      "gD"
      { __raw = "vim.lsp.buf.declaration"; }
      { options.desc = "[G]oto [D]eclaration"; }
    ]
    # Execute a code action, usually your cursor needs to be on top of an error
    # or a suggestion from your LSP for this to activate.
    [
      "n"
      "<leader>ca"
      { __raw = "vim.lsp.buf.code_action"; }
      { options.desc = "[C]ode [A]ction"; }
    ]
    # Rename the variable under your cursor
    #  Most Language Servers support renaming across files, etc.
    [
      "n"
      "<leader>rn"
      { __raw = "vim.lsp.buf.rename"; }
      { options.desc = "[R]e[n]ame"; }
    ]
  ];
}
