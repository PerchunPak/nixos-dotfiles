{
  appimageTools,
  fetchurl,
  makeWrapper,
  webkitgtk_4_1,
  libsoup_3,
  libayatana-appindicator,
}:
let
  pname = "arctracker-link";
  version = "2.1.8";

  src = fetchurl {
    url = "https://cdn.arctracker.io/link/linux/ARC-Tracker-Link-${version}-x86_64.AppImage";
    hash = "sha256-ERdbVsmIUwK6wA0LQDba0ZKYk6bvr4vXYJLEqYvokUg=";
  };

  appimageContents = appimageTools.extract {
    inherit version pname src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands = ''
    install -m 444 -D \
      ${appimageContents}/usr/share/applications/arctracker-link.desktop \
      $out/share/applications/arctracker-link.desktop
    install -m 444 -D \
      ${appimageContents}/usr/share/icons/hicolor/256x256/apps/arctracker-link.png \
      $out/share/icons/hicolor/256x256/apps/arctracker-link.png

    substituteInPlace $out/share/applications/arctracker-link.desktop \
      --replace-fail \
        'Exec=arctracker-link' \
        "Exec=$out/bin/arctracker-link"

    wrapProgram $out/bin/arctracker-link \
      --set APPIMAGE $out/bin/arctracker-link
  '';

  extraPkgs = pkgs: [
    webkitgtk_4_1
    libsoup_3
    libayatana-appindicator
  ];
}
