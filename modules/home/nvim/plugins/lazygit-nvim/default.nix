{channels, ...}: {
  programs.nixvim = {
    extraPlugins = with channels.unstable.vimPlugins; [
      lazygit-nvim
    ];
  };

  my.nvim.keymaps = [
    ["n" "<leader>g" ":LazyGit<CR>" {options.desc = "Open [G]it";}]
  ];
}
