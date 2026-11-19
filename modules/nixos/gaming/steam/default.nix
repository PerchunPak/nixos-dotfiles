{ lib, config, ... }:
let
  steamapps = "/persist/home/perchun/.local/share/Steam/steamapps";
in
{
  programs.steam = {
    enable = config.my.gui.enable;
    gamescopeSession.enable = config.my.gui.enable;
  };
  programs.gamemode.enable = config.my.gui.enable;

  environment.variables = {
    FONTCONFIG_PATH = "/etc/fonts";
  };

  systemd.tmpfiles.rules =
    lib.mkIf (config.programs.steam.enable && config.my.btrfs-snapshots.enable)
      [
        "d /persist/home/perchun/.local 0755 perchun users -"
        "d /persist/home/perchun/.local/share 0755 perchun users -"
        "d /persist/home/perchun/.local/share/Steam 0755 perchun users -"
        "v ${steamapps} 0755 perchun users -"
        "v ${steamapps}/compatdata 0755 perchun users -"
      ];

  my.btrfs-snapshots.subvolumes = lib.mkIf config.programs.steam.enable [
    "${steamapps}/compatdata"
  ];
}
