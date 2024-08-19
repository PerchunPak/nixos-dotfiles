{ inputs, system, ... }:
let
  nixCats = import ../../nvim { inherit inputs; };
in
nixCats.packages.${system}.default
