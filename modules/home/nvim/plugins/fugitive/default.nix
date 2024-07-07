# `:Git`
{
  programs.nixvim.plugins = {
    fugitive.enable = true;
  };

  my.nvim.keymaps = [
    [
      "n"
      "<leader>b"
      ":Git blame<CR><C-l>" # open git blame and move cursor to the file
    ]
    [
      "n"
      "<leader>P"
      ":G push<CR>"
    ]
    [
      "n"
      "<leader>hf" # help fugitive, I will need this a lot
      ":!open https://github.com/tpope/vim-fugitive#fugitivevim<CR>"
    ]
  ];
}
