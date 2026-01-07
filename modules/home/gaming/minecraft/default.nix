{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.gaming;
in
{
  options = {
    my.gaming.minecraft = {
      enable = (lib.my.mkEnableByDefaultOption "Minecraft") // {
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.minecraft.enable {
    home.packages = with pkgs; [ prismlauncher ];
    my.persistence.directories = [ ".local/share/PrismLauncher" ];
    programs.java.enable = true;
  };
}
