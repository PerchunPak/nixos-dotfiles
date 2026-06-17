{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    daemon.settings.data-root = "/persist/system/docker";
    enableOnBoot = false;
  };
  hardware.nvidia-container-toolkit.enable = config.my.gui.enable;
}
