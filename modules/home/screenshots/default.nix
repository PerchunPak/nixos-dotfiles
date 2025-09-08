{ pkgs, lib, ... }:
{
  programs.satty = {
    enable = true;
    settings = {
      general = {
        fullscreen = true;
        output-filename = "Pictures/screenshot-%Y-%m-%d-%H:%M:%S.png";
        save-after-copy = true;
        actions-on-right-click = [ "save-to-file" ];
        disable-notifications = true;
        copy-command = "wl-copy";
      };
      font.family = "MesloLGS NF Regular";
      color-palette = {
        palette = [
          "#f38ba8" # red
          "#cdd6f4" # text
          "#1e1e2e" # base
          "#f9e2af" # yellow
          "#a6e3a1" # green
          "#f5c2e7" # pink
          "#89b4fa" # blue
        ];
        custom = [
          "#f5e0dc" # rosewater
          "#f2cdcd" # flamingo
          "#cba6f7" # mauve
          "#eba0ac" # maroon
          "#fab387" # peach
          "#94e2d5" # teal
          "#89dceb" # sky
          "#74c7ec" # sapphire
          "#b4befe" # lavender
          "#bac2de" # subtext1
          "#a6adc8" # subtext0
          "#9399b2" # overlay2
          "#7f849c" # overlay1
          "#6c7086" # overlay0
          "#585b70" # surface2
          "#45475a" # surface1
          "#313244" # surface0
          "#181825" # mantle
          "#11111b" # crust
        ];
      };
    };
  };

  home.packages = with pkgs; [
    grimblast

    (pkgs.writeShellScriptBin "screenshot.sh" ''
      ${lib.getExe grimblast} --freeze save area - \
      | wl-copy
    '')
    (pkgs.writeShellScriptBin "screenshot-edit.sh" ''
      ${lib.getExe grimblast} --freeze save area - \
      | ${lib.getExe satty} --filename - --fullscreen
    '')
  ];
}
