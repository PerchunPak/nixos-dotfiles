{ inputs, pkgs, ... }:
let
  nixCats = import ../../../nvim {
    inherit pkgs;
    nixCats = inputs.nixCats;
  };
in
{
  home.packages = (builtins.attrValues nixCats);

  systemd.user.tmpfiles.rules = [
    "L /home/perchun/.config/nvim - - - - /home/perchun/dotfiles/nvim"
  ];

  my.persistence.directories = [
    ".local/state/nvim/dbee"
    ".local/state/nvim/shada"
    ".local/state/nvim/undo"
    ".local/share/nvim/devdocs"
  ];
}
