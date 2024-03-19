{
  stdenv,
  lib,
  fetchurl,
}: let
  inherit (stdenv.hostPlatform) system;
  throwSystem = throw "Unsupported system: ${system}";

  systemToPlatform = {
    "x86_64-linux" = {
      name = "linux-amd64";
      hash = "sha256-FKzvERcVYkyy1aNYHZIftC2WvSHRxFqSG/g7gpTTvoo=";
    };
    "aarch64-linux" = {
      name = "linux-arm64";
      hash = "sha256-4vX9On0upgfjM/IL/UzQj5ioeVnSsd2rUgIz6w4szZM=";
    };
    "x86_64-darwin" = {
      name = "darwin-amd64";
      hash = "sha256-W4ElKXsMo47dVRNJEnLzH2rpvkua56lj/NkJd3R8CCE=";
    };
    "aarch64-darwin" = {
      name = "darwin-arm64";
      hash = "sha256-F2OA66h/ptkjLZ2oQgkbZlDo31YDZzhk5Pre36TkHvI=";
    };
  };
  platform = systemToPlatform.${system} or throwSystem;
in
  stdenv.mkDerivation rec {
    pname = "gh-copilot";
    version = "0.5.4-beta";

    src = fetchurl {
      name = "gh-copilot";
      url = "https://github.com/github/gh-copilot/releases/download/v${version}/${platform.name}";
      hash = platform.hash;
    };

    dontUnpack = true;

    installPhase = ''
      install -m755 -D $src $out/bin/gh-copilot
    '';

    meta = with lib; {
      changelog = "https://github.com/github/gh-copilot/releases/tag/v${version}";
      description = "Ask for assistance right in your terminal.";
      homepage = "https://github.com/github/gh-copilot";
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      license = licenses.unfree;
      maintainers = with maintainers; [perchun];
      platforms = attrNames systemToPlatform;
      mainProgram = "gh-copilot";
    };
  }
