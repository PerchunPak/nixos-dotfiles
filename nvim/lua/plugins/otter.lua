return {
  'jmbuhr/otter.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    buffers = { write_to_disk = true },
    handle_leading_whitespace = false,
  },
}
