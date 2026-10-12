{ ... }:
final: prev: {
  trippy = prev.trippy.overrideAttrs rec {
    version = "0.14.0-dev";
    src = final.fetchFromGitHub {
      owner = "fujiapple852";
      repo = "trippy";
      rev = "38ce6acfc6ff3a1e697c3bc92f8c25d2429fd1e5";
      hash = "sha256-ONxqKbFi5Og6v5/im4jAT/s/jyDYnJJM1IiV9B6/HM8=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-h30tCs4E6Q77xTamP+Nwlb4ReASXmlaodtcnDbeTfBk=";
    };
  };
}
