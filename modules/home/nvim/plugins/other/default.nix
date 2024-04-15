{channels, ...}: {
  programs.nixvim = {
    plugins = {
      comment.enable = true;
      # Snippet Engine & its associated nvim-cmp source
      luasnip.enable = true;
      nvim-autopairs.enable = true;
      rainbow-delimiters.enable = true;
      # Highlight todo, notes, etc in comments
      todo-comments.enable = true;
      transparent.enable = true;
    };
    extraPlugins = with channels.unstable.vimPlugins; [
      neodev-nvim # used for completion, annotations and signatures of Neovim apis
      nvim-web-devicons # Useful for getting pretty icons, but requires a Nerd Font.
      vim-sleuth # Detect tabstop and shiftwidth automatically
    ];
  };
}
