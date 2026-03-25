return {
  'mini.nvim',
  lazy = false,
  after = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.basics').setup {}
    require('mini.comment').setup {}
    require('mini.cursorword').setup {}
    require('mini.icons').setup {}
    require('mini.move').setup {}
    require('mini.pairs').setup {}
    require('mini.surround').setup {}
  end,
}
