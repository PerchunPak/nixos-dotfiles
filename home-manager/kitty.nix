{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      name = "MesloLGS NF";
      package = pkgs.meslo-lgs-nf;
    };
    theme = "Darkside";
    settings = {
      font_size = "10.7";
      scrollback_pager_history_size = 10;
      scrollback_fill_enlarged_window = true;
      show_hyperlink_targets = true;
      tab_bar_style = "powerline";
      tab_separator = " ┇ ";
      tab_powerline_style = "slanted";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index} {title}";
      background_opacity = "0.93";
      background_blur = 64;
    };
  };
}
