{ lib, config, ... }:
let
  cfg = config.my.vm;
in
{
  options = {
    my.vm = {
      enable = lib.mkEnableOption "VM support";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
