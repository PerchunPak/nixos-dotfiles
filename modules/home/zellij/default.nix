{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      show_startup_tips = false;
      scroll_buffer_size = 1000000;
      scrollback_lines_to_serialize = 0;

      plugins = {
        zellij-autolock = {
          triggers = "v|nvim|vim|lazygit";
          reaction_seconds = "1.0";
        };
      };
    };
    extraConfig = builtins.readFile ./config.kdl;

    plugins = [ pkgs.zellijPlugins.zellij-autolock ];
  };
}
