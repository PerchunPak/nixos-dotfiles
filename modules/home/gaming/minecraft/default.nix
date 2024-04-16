{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.gaming;
in {
  options = {
    my.gaming.minecraft = {
      enable =
        (lib.my.mkEnableByDefaultOption "Minecraft")
        // {
          default = cfg.enable;
        };
    };
  };

  config =
    {
      # not settings this may delete my data, better to keep empty symlink
      my.persistence.directories = [".local/share/PrismLauncher"];
    }
    // (lib.mkIf cfg.minecraft.enable {
      home.packages = with pkgs; [
        prismlauncher
      ];
    });
}
