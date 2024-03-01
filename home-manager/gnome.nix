{pkgs, ...}: let
  extensions = with pkgs.gnomeExtensions; [
    blur-my-shell
    compiz-windows-effect
    dash-to-panel
    # material-you-theme # outdated for gnome 45
    rounded-window-corners
    tray-icons-reloaded
    caffeine
    appindicator
    burn-my-windows
    tiling-assistant
    # keyboard-layout-groups # self-written extention; needs to be repackaged manually - will do later, it doesn't work anyway
  ];
in {
  home.packages = extensions;

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = map (extension: extension.extensionUuid) extensions;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
  };
}
