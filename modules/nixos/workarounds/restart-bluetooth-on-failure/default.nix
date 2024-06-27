{
  systemd.services = {
    bluetooth.serviceConfig.Restart = "on-failure";
  };
}
