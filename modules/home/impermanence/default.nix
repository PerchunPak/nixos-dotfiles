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
}
