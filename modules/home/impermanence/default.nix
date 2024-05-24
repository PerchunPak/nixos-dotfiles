{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.my.persistence;
in
{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  options = {
    my.persistence = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
    };
  };

  config = {
    home.persistence."/persist/home" = {
      directories = [
        "ai"
        "dotfiles"
        "dev"
        "persistent"
        ".local/share/Steam"
      ] ++ cfg.directories;
      files = cfg.files;
      allowOther = true;
    };
  };
}
