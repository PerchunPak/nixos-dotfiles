{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];

  programs.zellij = {
    enable = true;

    settings = {
      show_startup_tips = false;
      scroll_buffer_size = 1000000;
      scrollback_lines_to_serialize = 0;
    };
    extraConfig = builtins.readFile ./config.kdl;
  };
}
