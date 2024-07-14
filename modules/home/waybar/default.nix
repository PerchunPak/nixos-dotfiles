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
}
