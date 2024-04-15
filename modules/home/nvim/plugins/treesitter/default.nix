# Highlight, edit, and navigate code
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      indent = true;
      # There are additional nvim-treesitter modules that you can use to interact
      # with nvim-treesitter. You should go explore a few and see what interests you:
      #
      #    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      #    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      #    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    };
  };
}
