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
      font_size = "13.0";
      scrollback_pager_history_size = 10;
      scrollback_fill_enlarged_window = true;
      show_hyperlink_targets = true;
      tab_bar_style = "powerline";
      tab_separator = " ┇ ";
      tab_powerline_style = "slanted";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index} {title}";
      background_opacity = "0.70";
    };

    keybindings =
      let
        increase-font-size = "change_font_size all +1.0";
        decrease-font-size = "change_font_size all -1.0";
      in
      {
        "ctrl+shift+equal" = increase-font-size;
        "ctrl+shift+plus" = increase-font-size;
        "ctrl+shift+kp_add" = increase-font-size;
        "ctrl+shift+minus" = decrease-font-size;
        "ctrl+shift+kp_subtract" = decrease-font-size;
      };
  };
}
