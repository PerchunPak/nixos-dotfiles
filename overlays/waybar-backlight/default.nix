{ ... }:
final: prev: {
  waybar = prev.waybar.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./proper-dbus-address.patch ];
  });
}
