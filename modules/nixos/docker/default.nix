{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    daemon.settings.data-root = "/persist/system/docker";
    enableOnBoot = false;
  };
}
