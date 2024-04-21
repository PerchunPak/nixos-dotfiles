# Useful for getting pretty icons, but requires a Nerd Font.
{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];

    extraConfigLua = ''
      require('nvim-web-devicons').setup()
    '';
  };
}
