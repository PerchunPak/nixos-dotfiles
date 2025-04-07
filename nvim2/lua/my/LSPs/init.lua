local function get_capabilities(server_name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

require('lze').load {
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
}

require 'my.LSPs.lua'
require 'my.LSPs.nix'
require 'my.LSPs.python'
