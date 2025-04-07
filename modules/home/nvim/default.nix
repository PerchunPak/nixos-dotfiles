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

  nixCats_2 = import ../../../nvim2 {
    inherit pkgs;
    nixCats = inputs.nixCats;
  };
in
{
  home.packages = (builtins.attrValues nixCats.packages.${system}) ++ [ nixCats_2.nvim2 ];

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
