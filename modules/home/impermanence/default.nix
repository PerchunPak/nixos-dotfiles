{ lib, ... }:
{
  # impermanence HM module uses bindfs, which has absurd performance cost
  # instead, we read these options from nixos impermanence module, and apply
  # them there. this has improved my performance 31 times better
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
    my.persistence = {
      directories = [
        ".cache/huggingface"
        # ".cache/nix" # https://github.com/nix-community/comma/issues/95
        ".config/Signal"
        ".config/asciinema"
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
