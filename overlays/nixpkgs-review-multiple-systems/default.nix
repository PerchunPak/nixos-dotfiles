{ ... }:
final: prev: {
  nixpkgs-review = prev.nixpkgs-review.overrideAttrs (old: {
    version = "2.10.5-dev.53e593d";
    doInstallCheck = false; # bro i dont care

    src = final.fetchFromGitHub {
      owner = "Mic92";
      repo = "nixpkgs-review";
      rev = "53e593d9cab8264e88896d43a8ed99c995534a5e";
      hash = "sha256-oK8rhlYvkALOIL5CTfxX1jStXtIVYZHF8qP6EWwVkj4=";
    };
  });
}
