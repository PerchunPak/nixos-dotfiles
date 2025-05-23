return {
  'lazydev.nvim',
  cmd = { 'LazyDev' },
  ft = 'lua',
  on_require = {
    'lazydev.integrations.blink',
  },
  after = function()
    require('lazydev').setup {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        -- adds type hints for nixCats global
        {
          words = { 'nixCats' },
          path = (nixCats.nixCatsPath or '') .. '/lua',
        },
      },
    }
  end,
}
