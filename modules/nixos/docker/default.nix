{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    storageDriver = "btrfs";
    daemon.settings.data-root = "/persist/system/docker";
    enableOnBoot = false;
  };
  hardware.nvidia-container-toolkit.enable = true;
}
