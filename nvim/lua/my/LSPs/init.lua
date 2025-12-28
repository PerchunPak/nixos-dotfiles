return {
  {
    'nvim-lspconfig',
    on_require = { 'lspconfig' },
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
    keys = {
      {
        '<leader>ca',
        function()
          vim.lsp.buf.code_action()
        end,
        desc = 'Code Actions',
      },
      {
        '<leader>cr',
        function()
          vim.lsp.buf.rename()
        end,
        desc = 'Rename variable',
      },
    },
  },

  -- :help lspconfig-all
  { 'bashls', lsp = {} },
  { 'gleam', lsp = {} },
  { 'graphql', lsp = {} },
  { 'marksman', lsp = {} },
  { 'rust_analyzer', lsp = {} },
  { 'typos_lsp', lsp = {} },
  { 'yamlls', lsp = {} },

  { import = 'my.LSPs.frontend' },
  { import = 'my.LSPs.lua' },
  { import = 'my.LSPs.nix' },
  { import = 'my.LSPs.python' },
}
