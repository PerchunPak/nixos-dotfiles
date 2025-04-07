return {
  'toggleterm.nvim',
  after = function()
    require('toggleterm').setup {
      open_mapping = [[<c-\>]],
      shade_terminals = false,
      terminal_mappings = true,
      -- for system reproducibility reasons
      persist_size = false,
      persist_mode = false,
    }
  end,
}
