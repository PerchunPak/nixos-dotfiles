{ config, lib, ... }:
{
  config = lib.mkIf config.my.gui.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
