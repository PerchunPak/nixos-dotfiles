{ ... }:
final: prev: {
  trippy = prev.trippy.overrideAttrs rec {
    version = "0.14.0-dev";
    src = final.fetchFromGitHub {
      owner = "fujiapple852";
      repo = "trippy";
      rev = "fa153633fe355fedd0fc8e481addbf37dd9c1514";
      hash = "sha256-bc6dlLR5j8h22H+LsawadBKvnMGh05L7G17X9Ipxbe8=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-TL+mZBoiQKUQ3H3L56f2lmIN0hCNmx8D9d05eP6/Pqs=";
    };
  };
}
