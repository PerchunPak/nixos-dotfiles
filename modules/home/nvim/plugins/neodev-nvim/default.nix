# `neodev` configures Lua LSP for your Neovim config, runtime and plugins
# used for completion, annotations and signatures of Neovim apis
{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      neodev-nvim
    ];

    extraConfigLua = ''
      require('neodev').setup()
    '';
  };
}
