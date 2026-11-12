{
  stdenv,
  btrfs-progs,
  fetchurl,
  busybox,
  writeShellApplication,
}:
let
  src = fetchurl {
    url = "https://raw.githubusercontent.com/ItsDrike/dotfiles/b93efba0fd22721be663e51c7c7d49cbc0d7a892/root/usr/local/bin/btrfs-backup";
    hash = "sha256-0qLJPRNKASHT3EN7RvIauMFg00/j/ujokpZYY/dSevw=";
  };
in
writeShellApplication {
  name = "btrfs-backup";
  text = ''
    # shellcheck disable=SC1091
    source ${src}
  '';
  runtimeInputs = [
    btrfs-progs
    busybox
  ];
  bashOptions = [ ];
  checkPhase = ''
    runHook preCheck
    ${stdenv.shellDryRun} "$target"
    ${stdenv.shellDryRun} ${src}
    runHook postCheck
  '';
}
