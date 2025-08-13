return {
  {
    'nvim-treesitter-context',
    event = 'DeferredUIEnter',
    after = function()
      require('treesitter-context').setup {
        multiline_threshold = 1,
      }
    end,
  },
}
