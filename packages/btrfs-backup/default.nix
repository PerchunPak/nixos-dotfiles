{ stdenv, fetchurl }:
stdenv.mkDerivation {
  name = "btrfs-backup";
  src = fetchurl {
    url = "https://raw.githubusercontent.com/ItsDrike/dotfiles/b93efba0fd22721be663e51c7c7d49cbc0d7a892/root/usr/local/bin/btrfs-backup";
    hash = "sha256-0qLJPRNKASHT3EN7RvIauMFg00/j/ujokpZYY/dSevw=";
  };
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/btrfs-backup
    chmod +x -R $out/bin
  '';

  meta.mainProgram = "btrfs-backup";
}
