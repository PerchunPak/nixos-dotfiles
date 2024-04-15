{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.unstable.vimPlugins; [
      lazygit-nvim
    ];
  };

  my.nvim.keymaps = [
    ["n" "<leader>g" ":LazyGit<CR>" {options.desc = "Open [G]it";}]
  ];
}
