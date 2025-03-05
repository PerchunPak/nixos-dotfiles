{ ... }:
final: prev: {
  variety = prev.variety.overrideAttrs {
    patches = [
      ./ln-wallpaper.patch
      ./always-assume-we-use-swaybg.patch
    ];
  };
}
