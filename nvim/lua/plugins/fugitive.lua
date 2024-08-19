return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>b', '<cmd>Git blame<CR><C-l>')
  end,
}
