{ ... }:
final: prev: {
  variety = prev.variety.overrideAttrs {
    patches = [
      ./ln-wallpaper.patch
    ];
  };
}
