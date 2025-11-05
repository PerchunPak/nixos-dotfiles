{ inputs, pkgs, ... }:
let
  nixCats = import ../../../nvim {
    inherit pkgs;
    nixCats = inputs.nixCats;
  };
in
{
  home.packages = (builtins.attrValues nixCats);

  systemd.user.tmpfiles.settings = {
    nvim-config.rules."/home/perchun/.config/nvim".L = {
      argument = "/home/perchun/dotfiles/nvim";
    };
  };

  my.persistence.directories = [
    ".local/state/nvim/dbee"
    ".local/state/nvim/shada"
    ".local/state/nvim/undo"
    ".local/share/nvim/devdocs"
  ];
}
