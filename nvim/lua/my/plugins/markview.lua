return {
  'markview.nvim',
  lazy = false,
  after = function()
    require('markview').setup {
      preview = { enable = false },
    }
  end,
  keys = {
    {
      '<leader>m',
      '<cmd>Markview toggle<cr>',
      mode = 'n',
      desc = 'Toggles `markview` previews',
    },
    {
      '<leader>M',
      '<cmd>Markview splitToggle<cr>',
      mode = 'n',
      desc = 'Toggles `markview` split previews',
    },
  },
}
