{
  lib,
  stdenvNoCC,
  makeWrapper,
  logger,
  flock,
}:
stdenvNoCC.mkDerivation {
  name = "doublepress";
  src = ./doublepress.sh;

  dontUnpack = true;

  buildInputs = [
    logger
    flock
  ];
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/doublepress.sh
    chmod +x -R $out/bin

    wrapProgram $out/bin/doublepress.sh \
      --prefix PATH : ${
        lib.makeBinPath [
          logger
          flock
        ]
      }
  '';

  meta = {
    mainProgram = "doublepress.sh";
    license = lib.licenses.mit;
  };
}
