{ ... }:
final: prev: {
  nixpkgs-review = prev.nixpkgs-review.overridePythonAttrs rec {
    version = "3.1.0";
    src = final.fetchFromGitHub {
      owner = "Mic92";
      repo = "nixpkgs-review";
      tag = version;
      hash = "sha256-G47bfu3IVsKx5Yhfe6H6w5qRcxF2sjd48xVGSeljv/I=";
    };
  };
}
