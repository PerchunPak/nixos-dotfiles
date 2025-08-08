return {
  {
    'nvim-treesitter-context',
    event = 'DeferredUIEnter',
    after = function()
      require('treesitter-context').setup {}
    end,
  },
}
