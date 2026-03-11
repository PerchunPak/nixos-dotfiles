{ inputs, ... }:
{
  imports = [ ./module.nix ];

  programs.wayle = {
    enable = true;

    settings = {
      bar = {
        layout = [
          {
            center = [ "window-title" ];
            left = [
              "hyprland-workspaces"
              "cava"
              "media"
            ];
            monitor = "*";
            right = [
              "volume"
              "network"
              "idle-inhibit"
              "bluetooth"
              "battery"
              "systray"
              "clock"
              "keyboard-input"
              "notifications"
            ];
          }
        ];
      };
      modules = {
        clock = {
          format = "%H:%M:%S";
          dropdown-show-seconds = false;
        };
        hyprland-workspaces = {
          app-icons-dedupe = false;
          app-icons-show = true;
          monitor-specific = false;
          show-special = false;
        };
        cava = {
          bars = 10;
          style = "wave";
          direction = "mirror";
          left-click = "dropdown:media";
        };
        idle-inhibit = {
          label-show = false;
          icon-inactive = "tb-zzz-symbolic";
          icon-active = "tb-zzz-off-symbolic";
        };
        keyboard-input = {
          icon-show = false;
          language-name-map = {
            "English (US)" = "🇺🇸";
            "Czech (QWERTY)" = "🇨🇿";
            "Ukrainian" = "🇺🇦";
            "Russian" = "💩";
          };
        };

        weather.location = "Prague";

        window-title.label-max-length = 30;
        media.label-max-length = 30;

        bluetooth.label-show = false;
        microphone.label-show = false;
        network.label-show = false;
      };
    };
  };

  xdg.dataFile = {
    "wayle/icons/hicolor/scalable/actions/tb-zzz-symbolic.svg".source =
      "${inputs.storage}/icons/tb-zzz-symbolic.svg";
    "wayle/icons/hicolor/scalable/actions/tb-zzz-off-symbolic.svg".source =
      "${inputs.storage}/icons/tb-zzz-off-symbolic.svg";
  };
}
