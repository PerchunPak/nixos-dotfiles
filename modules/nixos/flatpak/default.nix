{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.flatpak;
in
{
  options = {
    my.flatpak = {
      enable = lib.mkEnableOption "Flatpak";
    };
  };

  config = lib.mkIf cfg.enable {
    my.persistence.directories = [ "/var/lib/flatpak" ];

    services.flatpak.enable = true;

    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
