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
  rofi-menu = pkgs.writeShellScript "rofi-menu" ''
    exec rofi -show "$1" -calc-command "echo -n '{result}' | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"
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
          ${lib.getExe pkgs.ydotool} click $YDOTOOL_BUTTON_LEFT > /dev/null
        done
      ) &
      pid=$!
      printf $pid > $pid_file
      disown
    fi
    exit 0
  '';

  spawn-btop-workspace = pkgs.writeShellScript "spawn-btop-workspace.sh" ''
    zellij delete-session btop || true
    exec alacritty -e zellij --new-session-with-layout btop --session btop
  '';
in
{
  wayland.windowManager.hyprland = lib.mkIf nixosConfig.my.gui.enable {
    settings = {
      monitor = cfg.monitors;
    };

    extraConfig = "require('./hyprland-conf')";
  };

  # env variables should be specified here
  xdg.configFile = {
    "hypr/hyprland-conf.lua".source = pkgs.replaceVars ./conf.lua {
      inherit
        wlogout-script
        rofi-menu
        rofi-calc-with-copy
        autoclicker-script
        spawn-btop-workspace
        ;
      econom_internet_traffic = nixosConfig.my.economInternetTraffic;
    };

    "uwsm/env".text = ''
      export LIBVA_DRIVER_NAME=nvidia
      export XDG_SESSION_TYPE=wayland
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
    '';
  };
}
