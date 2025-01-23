{ inputs, ... }:
{
  programs.hyprpanel = {
    enable = true;

    settings = {
      "bar.autoHide" = "never";
      "bar.battery.hideLabelWhenFull" = true;
      "bar.battery.label" = true;
      "bar.clock.format" = "%H:%M:%S";
      "bar.clock.icon" = "";
      "bar.clock.showTime" = true;
      "bar.customModules.updates.pollingInterval" = 1440000;
      "bar.launcher.autoDetectIcon" = true;
      "bar.media.show_active_only" = true;
      "bar.media.show_label" = true;
      "bar.media.truncation" = false;
      "bar.network.showWifiInfo" = true;
      "bar.network.truncation" = false;
      "bar.notifications.hideCountWhenZero" = true;
      "bar.notifications.show_total" = true;
      "bar.windowtitle.custom_title" = true;
      "bar.windowtitle.title_map" = [ ];
      "bar.workspaces.applicationIconMap" = {
        "class:vesktop$" = "";
      };
      "bar.workspaces.applicationIconOncePerWorkspace" = false;
      "bar.workspaces.monitorSpecific" = false;
      "bar.workspaces.numbered_active_indicator" = "underline";
      "bar.workspaces.scroll_speed" = 5;
      "bar.workspaces.showApplicationIcons" = true;
      "bar.workspaces.showWsIcons" = true;
      "bar.workspaces.show_icons" = false;
      "bar.workspaces.show_numbered" = false;
      "bar.workspaces.workspaces" = 1;
      "menus.clock.time.military" = true;
      # please don't hack me (1)
      "menus.clock.weather.key" = "629e10ff3d954b6481a105403251701";
      "menus.clock.weather.location" = "Prague";
      "menus.clock.weather.unit" = "metric";
      "menus.dashboard.controls.enabled" = true;
      "menus.dashboard.directories.enabled" = false;
      "menus.dashboard.powermenu.avatar.image" = "${inputs.storage}/avatars/white.png";
      "menus.dashboard.powermenu.confirmation" = true;
      "menus.dashboard.shortcuts.enabled" = false;
      "menus.dashboard.stats.enable_gpu" = true;
      "menus.media.displayTime" = true;
      "menus.media.displayTimeTooltip" = true;
      "menus.power.lowBatteryNotification" = true;
      "menus.power.showLabel" = true;
      "menus.transition" = "crossfade";
      "menus.volume.raiseMaximumVolume" = false;
      "notifications.clearDelay" = 0;
      "notifications.showActionsOnHover" = true;
      "theme.bar.border.location" = "none";
      "theme.bar.buttons.battery.enableBorder" = false;
      "theme.bar.buttons.clock.enableBorder" = false;
      "theme.bar.buttons.dashboard.enableBorder" = false;
      "theme.bar.buttons.enableBorders" = false;
      "theme.bar.buttons.network.enableBorder" = false;
      "theme.bar.buttons.systray.enableBorder" = false;
      "theme.bar.buttons.volume.enableBorder" = false;
      "theme.bar.buttons.windowtitle.enableBorder" = false;
      "theme.bar.buttons.workspaces.enableBorder" = false;
      "theme.bar.buttons.workspaces.smartHighlight" = true;
      "theme.bar.floating" = true;
      "theme.font.weight" = 400;
      "theme.osd.enable" = true;
      "theme.osd.muted_zero" = false;
      "theme.osd.orientation" = "vertical";
      "wallpaper.enable" = false;

      "bar.layouts" = {
        "*" = {
          left = [
            "dashboard"
            "workspaces"
            "media"
          ];
          middle = [ "windowtitle" ];
          right = [
            "volume"
            "network"
            "hypridle"
            "bluetooth"
            # "battery" # TODO disable if there is no battery
            "systray"
            "clock"
            "kbinput"
            "notifications"
          ];
        };
      };
    };
  };
}
