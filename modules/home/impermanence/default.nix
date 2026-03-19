{ lib, ... }:
{
  imports = [
    (lib.modules.mkAliasOptionModule [ "my" "persistence" ] [ "home" "persistence" "/persist" ])
  ];

  config = {
    my.persistence = {
      directories = [
        ".cache/claude-cli-nodejs"
        ".cache/huggingface"
        ".cache/nix"
        ".claude"
        ".config/asciinema"
        ".config/harper-ls"
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
      files = [ ".claude.json" ];
    };
  };
}
