{ ... }:
final: prev: {
  trippy = prev.trippy.overrideAttrs rec {
    version = "0.14.0-dev";
    src = final.fetchFromGitHub {
      owner = "PerchunPak";
      repo = "trippy";
      rev = "dd1c1bee58c6e5afec2d56bed7085097fd504a6f";
      hash = "sha256-VnixlsNiSLk55gIlGBBu0A58ZJ/wsAXKbeZHZL6jCWw=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-fPvpCDbYYGTYjzb5WozADzJA7GYWOwz6rq5XUIDpRVY=";
    };
  };
}
