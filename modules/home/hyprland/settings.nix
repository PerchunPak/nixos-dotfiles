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
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm app -s b -- swaybg"
      "[workspace 1 silent] uwsm app -- floorp"
      "uwsm app -- vesktop"
      "[workspace special:btop silent] uwsm app -- kitty btop"
    ] ++ (lib.lists.optional (!nixosConfig.my.economInternetTraffic) "uwsm app -s b -- variety");

    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "SUPER, Q, exec, kitty"
      "SUPER, C, killactive,"
      "SUPER, M, exec, hyprctl dispatch dpms on"
      "SUPER, E, exec, nautilus"
      "SUPER, V, togglefloating,"
      "SUPER, R, exec, rofi -show drun"
      "SUPER, P, pseudo, # dwindle"
      "SUPER, J, togglesplit, # dwindle"
      "SUPER, F, fullscreen"
      "SUPER, L, exec, hyprlock"
      "SUPER, K, exec, ${wlogout-script}"
      "SUPER, G, exec, hyprpanel toggleWindow settings-dialog"
      "SUPER, O, exec, bash -c 'pgrep vesktop -f | xargs kill'"
      "SUPER, W, exec, cliphistory"
      "SUPER, B, exec, variety --next"
      "SUPER SHIFT, B, exec, variety --previous"

      # Move focus with mainMod + arrow keys
      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "SUPER, S, togglespecialworkspace"
      "SUPER SHIFT, S, movetoworkspace, special"
      "SUPER, N, togglespecialworkspace, btop"

      # Scroll through existing workspaces with mainMod + scroll
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"

      ", PRINT, exec, hyprshot --mode region --clipboard-only --silent --freeze"

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
      "workspace 3 silent,class:^(vesktop)"
      "workspace 4 silent,class:^(steam)"
      "workspace 4 silent,class:^(heroic)"
      "workspace 4 silent,class:^(Minecraft)"
    ];

    windowrulev2 = [
      "float,class:(steam),title:(Friends List)"
      "size 383 691,class:(steam),title:(Friends List)"
      "center,class:(steam),title:(Friends List)"
      "workspace 4,class:(steam),title:(Friends List)"
    ];

    layerrule = [ "blur, logout_dialog" ];

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

    gestures.workspace_swipe = true;

    bezier = [ "easeOutExpo,0.16,1,0.3,1" ];
    animation = [ "workspaces,1,2,easeOutExpo,slide" ];

    monitor = cfg.monitors;

    cursor.no_hardware_cursors = true;
  };

  # env variables should be specified here
  xdg.configFile."uwsm/env".text = ''
    export LIBVA_DRIVER_NAME=nvidia"
    export XDG_SESSION_TYPE=wayland"
    export GBM_BACKEND=nvidia-drm"
    export __GLX_VENDOR_LIBRARY_NAME=nvidia"
  '';
}
