{ pkgs, ... }:
{
  catppuccin.rofi.enable = false;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = {
      "@theme" = "${./theme.rasi}";
    };
    extraConfig = {
      modi = "drun,ssh,run";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-ssh = " 󰌘 Ssh ";
      drun-display-format = "{icon} {name}";
      show-icons = true;
      sidebar-mode = true;
      ssh-client = "kitten ssh";
      terminal = "kitty";
    };
  };
}
