{
  catppuccin.hyprlock.useDefaultConfig = false;

  programs.hyprlock.settings = {
    general.disable_loading_bar = true;

    background = {
      path = "$HOME/.background-image";
      # color = "$base";

      blur_size = 4;
      blur_passes = 3;
      noise = 1.17e-2;
      contrast = 1.3;
      brightness = 0.8;
      vibrancy = 0.21;
      vibrancy_darkness = 0.0;
    };

    input-field = {
      size = "400, 50";
      outline_thickness = 3;
      dots_size = 0.3; # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true;
      dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
      outer_color = "$accent";
      inner_color = "$mantle";
      font_color = "$text";
      fade_on_empty = false;
      placeholder_text = "";
      hide_input = false;
      rounding = -1; # -1 means complete rounding (circle/oval)
      check_color = "$yellow";
      fail_color = "$red";
      fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
      fail_transition = 300; # transition time in ms between normal outer_color and fail_color
      capslock_color = "$mauve";
      numlock_color = "$mauve";
      bothlock_color = "$mauve";
      invert_numlock = false; # change color if numlock is off

      position = "0, -100";
      halign = "center";
      valign = "center";
    };

    label = [
      {
        text = "Welcome back, $USER <span foreground='##$pinkAlpha'>:3</span>";
        color = "$subtext1";
        font_size = 16;

        position = "0, -50";
        halign = "center";
        valign = "center";
      }

      # Hours
      {
        text = "cmd[update:1] echo \"<b><big> $(date +\"%H:%M:%S\") </big></b>\"";
        color = "$text";
        font_size = 36;
        shadow_passes = 3;
        shadow_size = 4;

        position = "0, 100";
        halign = "center";
        valign = "center";
      }

      # Today
      {
        text = "cmd[update:18000000] echo \"<big> \"$(date +'%A, %d.%m.%Y')\" </big>\"";
        color = "$subtext1";
        font_size = 24;

        position = "0, 50";
        halign = "center";
        valign = "center";
      }

      # Layout
      {
        monitor = "";
        text = "Layout: $LAYOUT";
        color = "$text";
        font_size = 15;
        font_family = "$font";
        position = "15, -15";
        halign = "left";
        valign = "top";
      }
    ];
  };
}
