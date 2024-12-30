{ channels, ... }:
final: prev: {
  stable = channels.nixpkgs-stable;

  electron_31 = final.stable.electron_31;
}
