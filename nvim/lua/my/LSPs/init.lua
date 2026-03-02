return {
  {
    'nvim-lspconfig',
    on_require = { 'lspconfig' },
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp)
      if not plugin.disable then
        vim.lsp.enable(plugin.name)
      end
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

  {
    'harper_ls',
    disable = true,
    lsp = {
      settings = {
        ['harper-ls'] = {
          linters = {
            SentenceCapitalization = false,
            SpellCheck = false,
          },
        },
      },
    },
  },

  { import = 'my.LSPs.frontend' },
  { import = 'my.LSPs.lua' },
  { import = 'my.LSPs.nix' },
  { import = 'my.LSPs.python' },
}
