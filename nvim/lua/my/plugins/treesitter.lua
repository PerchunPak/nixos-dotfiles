return {
  {
    'nvim-treesitter',
    lazy = false,
    after = function()
      local nix_info = require(vim.g.nix_info_plugin_name)
      local grammars_dir = nix_info.plugins.start.COLLATED_TS_GRAMMARS
      require('nvim-treesitter').setup {
        install_dir = grammars_dir,
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
