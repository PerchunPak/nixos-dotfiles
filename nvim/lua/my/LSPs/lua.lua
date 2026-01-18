return {
  'lua_ls',
  lsp = {
    filetypes = { 'lua' },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        formatters = {
          ignoreComments = true,
        },
        signatureHelp = { enabled = true },
        -- diagnostics = {
        --   globals = { 'vim' },
        --   disable = { 'missing-fields' },
        -- },
        telemetry = { enabled = false },
      },
    },
  },
}
