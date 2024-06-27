{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;

    shellIntegration.enableFishIntegration = true;

    font = {
      name = "MesloLGS NF";
      package = pkgs.meslo-lgs-nf;
    };

    settings = {
      font_size = "14.0";
      scrollback_pager_history_size = 10;
      scrollback_fill_enlarged_window = true;
      show_hyperlink_targets = true;
      tab_bar_style = "powerline";
      tab_separator = " ┇ ";
      tab_powerline_style = "slanted";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index} {title}";
      background_opacity = "0.90";
      background_blur = 64;
    };
  };

  home.file.".cache/kitty/main.json".text = ''
    {"window-size": [2560, 1360]}
  '';
}
