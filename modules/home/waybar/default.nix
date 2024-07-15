{ pkgs, lib, ... }:
{
  programs.waybar = {
    settings.mainBar = lib.mkMerge [
      (builtins.fromJSON (builtins.readFile ./config.json))
      {
        "hyprland/language" = {
          on-scroll-up = pkgs.writeShellScript "switch-layout-next" ''
            hyprctl devices -j | jq '.keyboards[] | select(.main).name' | xargs -I % hyprctl switchxkblayout % prev
          '';
          on-scroll-down = pkgs.writeShellScript "switch-layout-prev" ''
            hyprctl devices -j | jq '.keyboards[] | select(.main).name' | xargs -I % hyprctl switchxkblayout % next
          '';
        };
      }
    ];
    style = builtins.readFile ./style.css;
    systemd.enable = true;
  };

  home.packages = [
    (pkgs.writeShellScriptBin "waybar-dev" ''
      set -xe
      cd ~/.config/waybar

      mv config config1
      ln -s ~/dotfiles/modules/home/waybar/config.json config

      mv style.css style.css1
      ln -s ~/dotfiles/modules/home/waybar/style.css style.css
      # add catppuccin import
      head -n 2 style.css1 | cat - style.css > tmp && cat tmp > style.css && rm tmp

      trap "$(cat <<-END
        ${pkgs.toybox}/bin/killall waybar;
        rm style.css && mv style.css1 style.css;
        rm config && mv config1 config;
        tail -n +3 style.css > tmp && cat tmp > style.css && rm tmp;
        cd -
      END
      )" EXIT

      while true; do
        waybar &
        ${pkgs.inotify-tools}/bin/inotifywait -e create,modify $HOME/.config/waybar/config $HOME/.config/waybar/style.css
        ${pkgs.toybox}/bin/killall waybar
      done
    '')
  ];
}
