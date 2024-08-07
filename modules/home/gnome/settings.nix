{ lib, ... }:
{
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
      cursor-size = 32;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      center-new-windows = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 600;
    "org/gnome/desktop/peripherals/mouse".speed = -0.75;
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
    "org/gnome/settings-daemon/plugins".media-keys = 2; # volume adjustment step

    "org/gnome/desktop/wm/keybindings" = {
      show-desktop = [ "<Super>d" ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      switch-input-source = [ "<Shift>Alt_L" ];
    };

    ### Custom keybindings ###

    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
    ];

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Mission Center";
      command = "missioncenter";
      binding = "<Shift><Control>Escape";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Kitty";
      command = "kitty";
      binding = "<Super>t";
    };

    ### Apps section ###

    "org/gnome/pomodoro/preferences" = {
      pomodoro-duration = 1800.0;
      short-break-duration = 420.0;
      hide-system-notifications = true;
      enabled-plugins = [
        "sounds"
        "dark-theme"
        "notifications"
      ];
    };
    # goes with gnome-pomodoro settings
    "org/gnome/desktop/notifications".show-banners = true;
  };
}
