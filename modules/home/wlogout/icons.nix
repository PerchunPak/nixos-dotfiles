{ inputs, lib, ... }:
{
  xdg.configFile =
    let
      icons = [
        "hibernate"
        "lock"
        "logout"
        "reboot"
        "shutdown"
        "suspend"
      ];
    in
    builtins.listToAttrs (
      map (
        icon-name:
        lib.nameValuePair "wlogout/icons/${icon-name}.png" {
          source = "${inputs.storage}/wlogout-icons/${icon-name}.png";
        }
      ) icons
    );
}
