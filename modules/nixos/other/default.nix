{ pkgs, config, ... }:
{
  environment.defaultPackages = with pkgs; [ ];

  programs = {
    trippy.enable = true;
    partition-manager.enable = config.my.gui.enable;
  };

  services = {
    atd.enable = true;
  };

  systemd = {
    settings.Manager.DefaultTimeoutStopSec = "30s";
    user.settings.Manager.DefaultTimeoutStopSec = config.systemd.settings.Manager.DefaultTimeoutStopSec;
    coredump.settings.Coredump = {
      Storage = "none";
      ProcessSizeMax = 0;
    };
  };

  security.sudo.extraConfig = ''
    Defaults pwfeedback
    Defaults insults
  '';

  security.pam.services = {
    sudo.nodelay = true;
  };
}
