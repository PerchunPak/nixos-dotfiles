require('lze').load {
  'catppuccin-nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  after = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
      custom_highlights = function(c)
        return {
          NormalFloat = { bg = c.base },
        }
      end,
    }

    vim.cmd.colorscheme 'catppuccin'
    vim.api.nvim_set_hl(0, 'cursorline', { bg = nil })
  end,
}
