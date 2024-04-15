{
  lib,
  config,
  ...
}: let
  cfg = config.my.persistence;
in {
  options = {
    my.persistence = {
      directories = lib.mkOption {type = lib.types.listOf lib.types.str;};
      files = lib.mkOption {type = lib.types.listOf lib.types.str;};
    };
  };

  config = {
    home.persistence."/persist/home" = {
      directories =
        [
          "dotfiles"
          "dev"
          "persistent"
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
          {
            directory = ".local/share/Steam";
            method = "symlink";
          }
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
