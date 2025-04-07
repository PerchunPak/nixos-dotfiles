return {
  {
    'nvim-treesitter',
    event = 'DeferredUIEnter',
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd 'nvim-treesitter-textobjects'
    end,
    after = function(plugin)
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = false },
      }
    end,
  },
}
