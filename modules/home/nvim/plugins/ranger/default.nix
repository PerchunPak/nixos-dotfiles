{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.my.ranger-nvim ];

    extraConfigLua = ''
      require('ranger-nvim').setup({
        enable_cmds = true,
        replace_netrw = true,
      })
    '';
  };

  my.nvim.keymaps = [
    [
      "n"
      "<leader>f"
      ":Ranger<CR>"
      { options.desc = "Open Ranger ([F]ile manager)"; }
    ]
  ];
}
