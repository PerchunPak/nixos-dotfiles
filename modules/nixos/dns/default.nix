let
  nameservers = [
    # OpenDNS
    "208.67.222.222"
    "208.67.220.220"
    # NextDNS
    "45.90.28.142"
    "45.90.30.142"
  ];
in
{
  services.dnsmasq = {
    enable = true;
    settings.server = nameservers;
  };

  networking.networkmanager.dns = "dnsmasq";
  networking.nameservers = nameservers;
}
