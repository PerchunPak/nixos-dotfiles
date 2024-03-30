{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home" = {
    directories = [
      "dotfiles"
      "dev"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/fish"
      ".mozilla"
      ".local/share/pypoetry"
      ".cache/pypoetry"
      ".local/share/PrismLauncher"
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
