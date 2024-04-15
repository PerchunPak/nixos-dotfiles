{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # overwrite nixpkgs with unstable branch
    ({...} @ args: (inputs.nixvim.homeManagerModules.nixvim (args // {pkgs = pkgs.unstable;})))
  ];

  programs.nixvim = {
    enable = true;
    enableMan = false;
    clipboard.providers.wl-copy.enable = true;

    extraConfigLua = ''
      -- Highlight when yanking (copying) text
      --  Try it with `yap` in normal mode
      --  See `:help vim.highlight.on_yank()`
      vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
        callback = function()
          vim.highlight.on_yank()
        end,
      })
    '';
  };
}
