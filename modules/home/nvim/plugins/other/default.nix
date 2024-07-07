{ ... }:
{
  programs.nixvim = {
    plugins = {
      comment.enable = true;
      luasnip.enable = true; # Snippet Engine & its associated nvim-cmp source
      nvim-autopairs.enable = true;
      rainbow-delimiters.enable = true;
      transparent.enable = true;
      sleuth.enable = true;
    };
  };
}
