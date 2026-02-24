{ lib, ... }:
{
  imports = [
    (lib.modules.mkAliasOptionModule [ "my" "persistence" ] [ "home" "persistence" "/persist" ])
  ];

  config = {
    my.persistence = {
      directories = [
        ".cache/huggingface"
        ".cache/nix"
        ".config/asciinema"
        ".eclipse"
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
