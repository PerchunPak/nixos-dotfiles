local function get_capabilities(server_name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
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
  },

  { 'bashls', lsp = {} },
  { 'gleam', lsp = {} },
  { 'marksman', lsp = {} },
  { 'rust_analyzer', lsp = {} },
  { 'svelte', lsp = {} },
  { 'tailwindcss', lsp = {} },
  { 'ts_ls', lsp = {} },
  { 'typos_lsp', lsp = {} },
  { 'yamlls', lsp = {} },

  { import = 'my.LSPs.lua' },
  { import = 'my.LSPs.nix' },
  { import = 'my.LSPs.python' },
}
