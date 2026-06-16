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

  security.sudo.extraConfig = ''
    Defaults pwfeedback
    Defaults insults
  '';

  security.pam.services = {
    sudo.nodelay = true;
  };
}
