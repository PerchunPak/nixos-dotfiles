{
  inputs,
  pkgs,
  system,
  ...
}:
let
  nixCats = import ../../../nvim {
    inherit inputs;
    origPkgs = pkgs;
  };
in
{
  home.packages = builtins.attrValues nixCats.packages.${system};

  systemd.user.tmpfiles.rules = [
    "L /home/perchun/.config/nvim - - - - /home/perchun/dotfiles/nvim"
  ];

  my.persistence.directories = [
    ".local/state/nvim/dbee"
    ".local/state/nvim/shada"
    ".local/state/nvim/undo"
  ];
}
