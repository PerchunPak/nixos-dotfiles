{ lib, inputs, ... }:
{
  imports = [
    (import "${inputs.impermanence}/home-manager.nix")
    (lib.modules.mkAliasOptionModule [ "my" "persistence" ] [ "home" "persistence" "/persist" ])
  ];

  config = {
    # on my work machine, I only use home-manager, so `nixosConfig` is
    # unavailable and so is impermanence's module. I have patched impermanence
    # to not automatically import this module, so I can have it even when
    # I don't use impermanence
    home._nixosModuleImported = true;

    my.persistence = {
      directories = [
        ".cache/huggingface"
        ".cache/nix"
        ".config/Actual"
        ".config/Signal"
        ".config/asciinema"
        ".config/harper-ls"
        ".local/share/Actual"
        ".local/share/DBeaverData"
        ".local/share/Steam"
        ".local/share/docker"
        ".local/share/flatpak"
        ".local/state/wireplumber"
        ".steam"
        "ai"
        "dev"
        "dotfiles"
        "persistent"
      ];
    };
  };
}
