{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.my.persistence;
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options = {
    my.persistence = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
    };
  };

  config = {
    home.persistence."/persist/home" = {
      directories =
        [
          "dotfiles"
          "dev"
          "persistent"
          "torrents"
          ".ssh"
          ".local/share/keyrings"
          ".local/share/direnv"
          ".local/share/fish"
          ".mozilla"
          ".cache/mozilla"
          ".local/share/pypoetry"
          ".cache/pypoetry"
          ".local/share/PrismLauncher"
          ".local/state/nvim/shada" # MRU on default screen
          ".local/state/nvim/undo" # Undo history
          ".local/share/Steam"
        ]
        ++ cfg.directories;
      files =
        [
          ".config/monitors.xml" # monitor configuration
          ".config/lazygit/state.yml"
        ]
        ++ cfg.files;
      allowOther = true;
    };
  };
}
