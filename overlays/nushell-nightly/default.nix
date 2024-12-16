{ ... }:
final: prev: {
  nushell = prev.nushell.overrideAttrs rec {
    version = "0.101.0-unstable";

    src = final.fetchFromGitHub {
      owner = "nushell";
      repo = "nushell";
      rev = "3760910f0bbf58e25787ee685046cd2837924882";
      hash = "sha256-R8mfQlcVmNJBCmFvviuGmw6CGggwSKbd6l5GNZ1ptnM=";
    };

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-fGCJ54YHu2g2aE03UBREvE7+/Tl374MbCwDQk5iayvI=";
    };
  };
}
