{
  pkgs,
  nixosConfig,
  lib,
  writeShellScript,
  ...
}:
let
  cfg = nixosConfig.my.hyprland;

  wlogout-script = writeShellScript "wlogout-script" ''
    flock -n "/var/run/user/(id -u)/wlogout.lock" wlogout
  '';
in
{
  wayland.windowManager.hyprland.settings = {
    env = [
      # Nvidia
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    ];

    exec-once = [
      "swaybg &"
      "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &"
      "nm-applet --indicator"
      "blueman-applet"

      "[workspace 1 silent] firefox"
      "vesktop"
    ] ++ (lib.lists.optional (!nixosConfig.my.economInternetTraffic) "variety &");

    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "nautilus";
    "$menu" = "rofi -show drun";

    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mainMod, Q, exec, $terminal"
      "$mainMod, C, killactive,"
      "$mainMod, M, exec, hyprctl dispatch dpms on"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, V, togglefloating,"
      "$mainMod, R, exec, $menu"
      "$mainMod, P, pseudo, # dwindle"
      "$mainMod, J, togglesplit, # dwindle"
      "$mainMod, F, fullscreen"
      "$mainMod, L, exec, hyprlock"
      "$mainMod, K, exec, ${wlogout-script}"
      "$mainMod, B, exec, variety --next"
      "$mainMod SHIFT, B, exec, variety --previous"

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      ", PRINT, exec, hyprshot --mode region --clipboard-only --silent"

      # fn keys
      ", code:121, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", code:122, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", code:123, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
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
      "float,^(Rofi)$"
      "center 1,^(Rofi)$"
      "pin,^(Rofi)$"
      "stayfocused,^(Rofi)$"

      "workspace 3 silent,^(vesktop)"
      "workspace 4 silent,^(steam)"
      "workspace 4 silent,^(heroic)"
      "workspace 4 silent,^(Minecraft)"
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
}
