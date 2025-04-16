local function get_capabilities(server_name)
  local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

return {
  {
    'nvim-lspconfig',
    on_require = { 'lspconfig' },
    lsp = function(plugin)
      require('lspconfig')[plugin.name].setup(vim.tbl_extend('force', {
        capabilities = get_capabilities(plugin.name),
      }, plugin.lsp or {}))
    end,
    keys = {
      {
        '<leader>ca',
        function()
          vim.lsp.buf.rename()
        end,
        desc = 'Code Actions',
      },
      {
        '<leader>cr',
        function()
          vim.lsp.buf.code_action()
        end,
        desc = 'Rename variable',
      },
    },
  },

  -- :help lspconfig-all
  { 'bashls', lsp = {} },
  { 'gleam', lsp = {} },
  { 'marksman', lsp = {} },
  { 'rust_analyzer', lsp = {} },
  { 'typos_lsp', lsp = {} },
  { 'yamlls', lsp = {} },

  { import = 'my.LSPs.frontend' },
  { import = 'my.LSPs.lua' },
  { import = 'my.LSPs.nix' },
  { import = 'my.LSPs.python' },
}
