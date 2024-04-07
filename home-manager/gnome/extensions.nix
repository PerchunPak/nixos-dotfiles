{pkgs, ...}: let
  extensions = with pkgs.gnomeExtensions; [
    blur-my-shell
    compiz-alike-magic-lamp-effect
    compiz-windows-effect
    dash-to-panel
    tray-icons-reloaded
    caffeine
    appindicator
    burn-my-windows
    tiling-assistant
    quick-lang-switch
    # keyboard-layout-groups # self-written extension; needs to be repackaged manually - will do later, it doesn't work anyway
  ];
in {
  home.packages = extensions;

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = map (extension: extension.extensionUuid) extensions;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = false;
    };
    "org/gnome/shell/extensions/burn-my-windows" = {
      show-support-dialog = false;
      last-prefs-version = 39;
    };
    "org/gnome/shell/extensions/caffeine" = {
      show-notifications = false;
    };
    "org/gnome/shell/extensions/ncom/github/hermes83/compiz-alike-magic-lamp-effect" = {
      duration = 350.0;
      x-tiles = 15.0;
      y-tiles = 15.0;
    };
    "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
      speedup-factor-divider = 22.0;
      mass = 20.0;
      resize-effect = true;
    };
    # automatically generated
    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover = true;
      animate-appicon-hover-animation-convexity = "{'RIPPLE': 2.0, 'PLANK': 1.0, 'SIMPLE': 0.0}";
      animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
      animate-appicon-hover-animation-rotation = "{'SIMPLE': 0, 'RIPPLE': 10, 'PLANK': 0}";
      animate-appicon-hover-animation-travel = "{'SIMPLE': 0.05, 'RIPPLE': 0.4, 'PLANK': 0.0}";
      animate-appicon-hover-animation-type = "SIMPLE";
      animate-appicon-hover-animation-zoom = "{'SIMPLE': 1.11, 'RIPPLE': 1.25, 'PLANK': 2.0}";
      appicon-margin = 8;
      appicon-padding = 6;
      available-monitors = [0 1];
      click-action = "MINIMIZE";
      desktop-line-use-custom-color = false;
      dot-position = "BOTTOM";
      dot-style-focused = "SEGMENTED";
      dot-style-unfocused = "DASHES";
      group-apps = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      intellihide = false;
      isolate-workspaces = false;
      leftbox-padding = -1;
      multi-monitors = true;
      panel-anchors = "{\"0\":\"MIDDLE\",\"1\":\"MIDDLE\"}";
      panel-element-positions = "{\"0\":[{\"element\":\"activitiesButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"showAppsButton\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}],\"1\":[{\"element\":\"activitiesButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"showAppsButton\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}]}";
      panel-element-positions-monitors-sync = false;
      panel-lengths = "{\"0\":100,\"1\":100}";
      panel-positions = "{\"0\":\"BOTTOM\",\"1\":\"BOTTOM\"}";
      panel-sizes = "{\"0\":56,\"1\":48}";
      primary-monitor = 0;
      progress-show-count = true;
      secondarymenu-contains-appmenu = true;
      secondarymenu-contains-showdetails = true;
      show-appmenu = false;
      show-apps-icon-file = "";
      show-favorites = true;
      show-favorites-all-monitors = true;
      show-running-apps = true;
      show-showdesktop-hover = true;
      showdesktop-button-width = 4;
      status-icon-padding = -1;
      stockgs-keep-dash = false;
      stockgs-panelbtn-click-only = true;
      taskbar-locked = true;
      trans-gradient-bottom-color = "#ffffff";
      trans-panel-opacity = 0.2;
      trans-use-custom-gradient = false;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = false;
      tray-padding = -1;
      tray-size = 0;
      window-preview-title-position = "TOP";
    };
    "org/gnome/shell/extensions/trayIconsReloaded" = {
      invoke-to-workspace = false;
    };
  };

  xdg.configFile = {
    "burn-my-windows/profiles/1712511832337322.conf".text = ''
      [burn-my-windows-profile]
      show-support-dialog=false
      profile-window-type=0
      profile-animation-type=0
      fire-enable-effect=true
    '';
  };
}
