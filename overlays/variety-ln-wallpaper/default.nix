{ ... }:
final: prev: {
  variety = prev.variety.overrideAttrs {
    patches = [
      (builtins.toFile "ln-wallpaper.patch" ''
        diff --git a/data/scripts/set_wallpaper b/data/scripts/set_wallpaper
        index 88cd516..d6facb5 100755
        --- a/data/scripts/set_wallpaper
        +++ b/data/scripts/set_wallpaper
        @@ -34,6 +34,8 @@
         # In the end put the path to the actual final wallpaper image file in the WP variable.
         # The default is to simply set WP=$1.
         WP=$1
        +rm ~/.background-image
        +ln -s "$WP" ~/.background-image


         # Enlightenment
      '')
    ];
  };
}
