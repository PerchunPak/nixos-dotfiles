{ ... }:
final: prev: {
  trippy = prev.trippy.overrideAttrs rec {
    version = "0.14.0-dev";
    src = final.fetchFromGitHub {
      owner = "PerchunPak";
      repo = "trippy";
      rev = "f5ba014f149d5fa0e662cc0834266fc285134a85";
      hash = "sha256-ah2MHIep7/ogVByaDGZIz63xnkmnF0MdkqU+ya3vcok=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-fPvpCDbYYGTYjzb5WozADzJA7GYWOwz6rq5XUIDpRVY=";
    };
  };
}
