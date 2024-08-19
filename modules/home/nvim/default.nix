{ inputs, system, ... }:
let
  nixCats = import ../../../nvim { inherit inputs; };
in
{
  home.packages = builtins.attrValues nixCats.packages.${system};

  systemd.user.tmpfiles.rules = [
    "L /home/perchun/.config/nvim - - - - /home/perchun/dotfiles/nvim"
  ];

  my.persistence.directories = [
    ".local/state/nvim/undo"
    ".local/state/nvim/shada"
  ];
}
