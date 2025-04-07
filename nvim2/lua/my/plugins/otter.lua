return {
  'otter.nvim',
  after = function()
    require('otter').setup {
      buffers = { write_to_disk = true },
      handle_leading_whitespace = false,
    }
  end,
}
