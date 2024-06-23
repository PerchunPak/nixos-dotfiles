{ ... }:
{
  programs.nixvim = {
    plugins = {
      comment.enable = true;
      # Snippet Engine & its associated nvim-cmp source
      luasnip.enable = true;
      nvim-autopairs.enable = true;
      rainbow-delimiters.enable = true;
      transparent.enable = true;
      sleuth.enable = true;
    };
  };
}
