{ ... }:
final: prev: {
  nushell = prev.nushell.overrideAttrs rec {
    version = "0.101.0-unstable";

    src = final.fetchFromGitHub {
      owner = "nushell";
      repo = "nushell";
      rev = "6367fb6e9eb9af58e794e95f6c73854b00144bf8";
      hash = "sha256-1Wuwb990mu2PLLDYProLnvao1dORV4O2Fsylp9jubgY=";
    };

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-fGCJ54YHu2g2aE03UBREvE7+/Tl374MbCwDQk5iayvI=";
    };
  };
}
