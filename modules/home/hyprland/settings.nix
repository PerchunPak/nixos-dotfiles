{
  pkgs,
  nixosConfig,
  lib,
  ...
}:
let
  cfg = nixosConfig.my.hyprland;

  wlogout-script = pkgs.writeShellScript "wlogout-script" ''
    flock -n "/var/run/user/$(id -u)/wlogout.lock" wlogout
  '';

  rofi-calc = "rofi -show calc -modi calc -no-show-match -no-sort";
  rofi-calc-with-copy = pkgs.writeShellScript "rofi-calc-with-copy" ''
    ${rofi-calc} | wl-copy
  '';
  rofi-calc-script = pkgs.writeShellScript "rofi-calc-script" ''
    output=$(${rofi-calc})
    if [[ -n "$output" ]]; then
      output=$(echo -n "$output" | tr ';' '\n')
      if [[ $output != *$'\n'* ]]; then
        output=$(echo -n "$output" | sed '1 s/.* = //')
      fi
      echo -n "$output" \
      | sed 's/approx\. //' \
      | wl-copy
    fi
  '';

  autoclicker-script = pkgs.writeShellScript "autoclicker" ''
    pid_file="/var/run/user/$(id -u)/autoclicker-pid"
    pid="$(cat $pid_file || true)"
    if [ -f $pid_file ] && [ -d "/proc/$pid" ]; then
      kill $pid
      rm $pid_file
    else
      rm $pid_file || true
      (
        YDOTOOL_BUTTON_LEFT=0xc0
        while true; do
            ${lib.getExe pkgs.ydotool} click $YDOTOOL_BUTTON_LEFT >>/dev/null
        done
      ) &
      pid=$!
      printf $pid > $pid_file
      disown
    fi
    exit 0
  '';
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm app -s b -- swaybg"
      "uwsm app -- zen"
      "uwsm app -- legcord"
      "[workspace special:btop silent] uwsm app -- kitty btop"
    ]
    ++ (lib.lists.optional (!nixosConfig.my.economInternetTraffic) "uwsm app -s b -- variety");

    bind = [
      "SUPER, A, exec, kitty"
      "SUPER, C, killactive,"
      "SUPER, M, exec, hyprctl dispatch dpms on"
      "SUPER, ., exec, nautilus"
      "SUPER, G, togglefloating,"
      "SUPER, D, exec, rofi -show drun"
      "SUPER, V, exec, ${rofi-calc-script}"
      "SUPER SHIFT, V, exec, ${rofi-calc-with-copy}"
      "SUPER, F, fullscreen"
      "SUPER, L, exec, hyprlock"
      "SUPER, K, exec, ${wlogout-script}"
      "SUPER, X, exec, cliphistory"
      "SUPER, B, exec, variety --next"
      "SUPER, P, pin"
      "ALT, F8, exec, ${autoclicker-script}"
      "SUPER, F9, exec, hyprpanel toggleWindow settings-dialog"
      "SUPER, F10, exec, bash -c 'pgrep legcord -f | xargs kill'"
      "SUPER SHIFT, B, exec, variety --previous"

      # Move focus with mainMod + arrow keys
      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, Q, workspace, 5"
      "SUPER, W, workspace, 6"
      "SUPER, E, workspace, 7"
      "SUPER, R, workspace, 8"

      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, Q, movetoworkspace, 5"
      "SUPER SHIFT, W, movetoworkspace, 6"
      "SUPER SHIFT, E, movetoworkspace, 7"
      "SUPER SHIFT, R, movetoworkspace, 8"

      "SUPER, S, togglespecialworkspace"
      "SUPER SHIFT, S, movetoworkspace, special"
      "SUPER, N, togglespecialworkspace, btop"

      ", PRINT, exec, screenshot.sh"
      "SHIFT, PRINT, exec, screenshot-edit.sh"

      # fn keys
      ", code:121, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", code:122, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", code:123, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    general = {
      gaps_out = 10;
      gaps_in = 5;
    };

    decoration = {
      rounding = 5;
      inactive_opacity = 0.8;

      dim_inactive = true;
      dim_strength = -0.2;

      blur = {
        size = 2;
        passes = 2;
      };
    };

    windowrule = [
      "workspace 1 silent,class:^(zen-beta)"
      "workspace 3 silent,class:^(legcord)"
      "workspace 4 silent,title:^(Steam)" # the dialog that updates steam on startup
      "workspace 4 silent,class:^(steam)"
      "workspace 4 silent,class:^(heroic)"
      "workspace 4 silent,class:^(Minecraft)"
      "workspace 5 silent,class:^(DBeaver)"

      # Deny stealing focus for DBeaver, this is really annoying
      "noinitialfocus,class:^(DBeaver)"
    ];

    windowrulev2 = [
      # Steam Friends List
      "float,class:(steam),title:(Список друзів)"
      "size 383 691,class:(steam),title:(Список друзів)"
      "center,class:(steam),title:(Список друзів)"
      "workspace 4,class:(steam),title:(Список друзів)"
      # Calculator
      "float,class:(org.gnome.Calculator)"
      "size 383 691,class:(org.gnome.Calculator)"
      "center,class:(org.gnome.Calculator)"
    ];

    layerrule = [
      "blur, logout_dialog"
      "noanim, hyprpicker"
      "noanim, selection"
    ];

    input = {
      sensitivity = -0.85;
      kb_layout = "us,cz,ua,ru";
      kb_variant = ",qwerty,,";
      kb_options = "grp:caps_toggle";
    };

    misc = {
      middle_click_paste = false;
      force_default_wallpaper = -1;
      disable_hyprland_logo = false;
    };

    device = [
      {
        name = "elan0515:00-04f3:3142-touchpad";
        sensitivity = 0;
      }
    ];

    gesture = [ "3, horizontal, workspace" ];

    bezier = [ "easeOutExpo,0.16,1,0.3,1" ];
    animation = [ "workspaces,1,2,easeOutExpo,slide" ];

    monitor = cfg.monitors;

    cursor.no_hardware_cursors = true;

    ecosystem.no_update_news = true;
  };

  # env variables should be specified here
  xdg.configFile."uwsm/env".text = ''
    export LIBVA_DRIVER_NAME=nvidia"
    export XDG_SESSION_TYPE=wayland"
    export GBM_BACKEND=nvidia-drm"
    export __GLX_VENDOR_LIBRARY_NAME=nvidia"
  '';
}
