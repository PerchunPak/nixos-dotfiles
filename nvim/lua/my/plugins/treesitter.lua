return {
  {
    'nvim-treesitter',
    lazy = false,
    after = function()
      require('nvim-treesitter').setup {
        install_dir = '/nix/store/f0wddl5kywsnszix4g3qldfcxzf3zm6r-vim-pack-dir/pack/myNeovimGrammars/start/vimplugin-treesitter-grammar-ALL-INCLUDED/',
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
