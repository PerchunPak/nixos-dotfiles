return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    name = 'catppuccin-nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      local flavour = 'mocha'
      require('catppuccin').setup {
        flavour = flavour,
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
  },
}
-- vim: ts=2 sts=2 sw=2 et
