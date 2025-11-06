{ ... }:
final: prev: {
  hyprpanel = prev.hyprpanel.overrideAttrs {
    patches = [
      ./app-icons-and-workspace-numbers.patch
      ./lang-flags-instead-of-names.patch
      ./more-app-icons.patch
    ];
  };
}
