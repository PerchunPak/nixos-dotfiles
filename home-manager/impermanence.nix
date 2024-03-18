{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home" = {
    directories = [
      "dotfiles"
      "dev"
      # "Downloads"
      # "Music"
      # "Pictures"
      # "Documents"
      # "Videos"
      # "VirtualBox VMs"
      # ".gnupg"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/fish"
      ".mozilla"
      ".local/share/pypoetry"
      ".cache/pypoetry"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      # ".screenrc"
    ];
    allowOther = true;
  };
}
