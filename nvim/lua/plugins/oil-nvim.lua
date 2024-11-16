return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      git = {
        add = function(path)
          return true
        end,
        mv = function(src_path, dest_path)
          return true
        end,
        rm = function(path)
          return true
        end,
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
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
