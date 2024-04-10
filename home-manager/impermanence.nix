{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home" = {
    directories = [
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
    ];
    files = [
      ".config/monitors.xml" # monitor configuration
      ".config/lazygit/state.yml"
    ];
    allowOther = true;
  };
}
