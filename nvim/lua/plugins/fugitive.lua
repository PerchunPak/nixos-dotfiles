return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR><C-l>')
  end,
}
