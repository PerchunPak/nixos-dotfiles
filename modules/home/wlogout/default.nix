{ config, ... }:
{
  imports = [ ./icons.nix ];

  programs.wlogout = {
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock [ L ]";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate [ H ]";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout [ O ]";
        keybind = "o";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown [ S ]";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend [ U ]";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot [ R ]";
        keybind = "r";
      }
    ];

    style =
      "@import \"${config.catppuccin.sources.waybar}/${config.catppuccin.flavor}.css\";\n\n"
      + (builtins.readFile ./style.css);
  };
}
