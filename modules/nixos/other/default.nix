{ pkgs, ... }:
{
  environment.defaultPackages = with pkgs; [ ];

  programs = {
    trippy.enable = true;
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
