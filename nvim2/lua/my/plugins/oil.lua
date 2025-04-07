return {
  'oil.nvim',
  after = function()
    require('oil').setup {
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open files' })
    vim.keymap.set(
      'n',
      '<leader>E',
      '<CMD>Oil --float<CR>',
      { desc = 'Open files (floating)' }
    )
  end,
}
