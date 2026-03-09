{ pkgs, ... }:
{
  imports = [ ./plugins-module.nix ];

  home.packages = [ pkgs.tmux ];

  programs.zellij = {
    enable = true;

    settings = {
      show_startup_tips = false;
      scroll_buffer_size = 1000000;
      scrollback_lines_to_serialize = 0;

      plugins = {
        vim-zellij-navigator = {
          vim_commands = "v|nvim|vim|testNvim";
        };
      };
    };
    extraConfig = builtins.readFile ./config.kdl;

    plugins = [ pkgs.zellijPlugins.vim-zellij-navigator ];
  };

  my.persistence.directories = [ ".cache/zellij" ];
}
