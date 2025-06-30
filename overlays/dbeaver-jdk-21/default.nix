{ ... }:
final: prev: {
  dbeaver-bin = prev.dbeaver-bin.override { openjdk17 = final.openjdk21; };
}
