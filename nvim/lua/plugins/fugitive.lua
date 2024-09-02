return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>cb', '<cmd>Git blame<CR><C-l>')
  end,
}
