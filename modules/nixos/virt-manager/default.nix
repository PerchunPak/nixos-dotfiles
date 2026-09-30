{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.gui.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
