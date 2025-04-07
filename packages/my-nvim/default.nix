{
  inputs,
  pkgs,
}:
(import ../../nvim {
  inherit pkgs;
  nixCats = inputs.nixCats;
}).neovim
