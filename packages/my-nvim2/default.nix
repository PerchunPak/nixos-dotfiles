{
  inputs,
  pkgs,
}:
(import ../../nvim2 {
  inherit pkgs;
  nixCats = inputs.nixCats;
}).testNvim
