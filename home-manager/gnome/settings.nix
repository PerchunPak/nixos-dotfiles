{lib, ...}: {
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "kitty.desktop"
        "vesktop.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      clock-show-seconds = true;
      text-scaling-factor = 1.3;
    };

    "org/gnome/mutter".dynamic-workspaces = true;
    "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 900;

    "org/gnome/desktop/wm/keybindings" = {
      show-desktop = ["<Super>d"];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };

    ### Apps section ###

    "org/gnome/pomodoro/preferences" = {
      pomodoro-duration = 1800.0;
      short-break-duration = 420.0;
      hide-system-notifications = true;
      enabled-plugins = ["sounds" "dark-theme" "notifications"];
    };
    # goes with gnome-pomodoro settings
    "org/gnome/desktop/notifications".show-banners = true;
  };
}
