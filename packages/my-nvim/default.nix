{
  inputs,
  pkgs,
  system,
}:
let
  nixCats = import ../../nvim {
    inherit inputs;
    origPkgs = pkgs;
  };
in
nixCats.packages.${system}.default
