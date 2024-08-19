{ inputs, ... }:
let
  nixCats = (import ../../../nvim { inherit inputs; });
in
{
  imports = [ nixCats.homeModule ];

  nixCats.enable = true;

  my.persistence.directories = [
    ".local/state/nvim/undo"
    ".local/state/nvim/shada"
  ];
}
