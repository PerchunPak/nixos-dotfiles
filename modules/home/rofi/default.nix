{
  pkgs,
  lib,
  nixosConfig,
  ...
}:
let
  clipboard = pkgs.writeShellScript "rofi-clipboard" ''
    set -uo pipefail
    export PATH=${
      lib.makeBinPath [
        pkgs.cliphist
        pkgs.wl-clipboard
        pkgs.coreutils
      ]
    }

    if [[ -z ''${1:-} ]]; then
      cliphist list
    else
      cliphist decode <<<"$1" | wl-copy
    fi
  '';
in
{
  catppuccin.rofi.enable = false;

  programs.rofi = {
    enable = nixosConfig.my.gui.enable;
    theme = {
      "@theme" = "${./theme.rasi}";
    };
    plugins = [ pkgs.rofi-calc ];
    settings = {
      modi = "drun,run,calc,clipboard:${clipboard}";
      display-drun = "Apps";
      display-run = "Run";
      display-clipboard = "Clipboard";
      display-calc = "Calc";

      # Tab cycles tabs. Tab and Shift+Tab are kb-element-next/prev by
      # default, and rofi refuses to start on a duplicate binding, so both
      # have to be cleared first.
      kb-element-next = "";
      kb-element-prev = "";
      kb-mode-next = "Tab";
      kb-mode-previous = "ISO_Left_Tab";
      drun-match-fields = "name,generic,keywords,categories";
      drun-display-format = "{icon} {name}";
      show-icons = true;
      sidebar-mode = true;
      terminal = "alacritty";
    };
  };
}
