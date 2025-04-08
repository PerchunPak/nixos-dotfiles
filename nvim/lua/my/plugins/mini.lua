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
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
