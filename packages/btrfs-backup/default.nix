{ stdenv, fetchurl }:
stdenv.mkDerivation {
  name = "btrfs-backup";
  src = fetchurl {
    url = "https://raw.githubusercontent.com/ItsDrike/dotfiles/11ef5e8a1ca4f2705659844df84df848f7e2446e/root/usr/local/bin/btrfs-backup";
    hash = "sha256-ZHyijplgFrf56FYz3MSh+P9kOVLZYQKUlrcxf0uWPj8=";
  };
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/btrfs-backup
    chmod +x -R $out/bin
  '';

  meta.mainProgram = "btrfs-backup";
}
