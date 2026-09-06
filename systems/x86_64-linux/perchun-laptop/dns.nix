let
  nameservers = [
    # OpenDNS
    "208.67.222.222"
    "208.67.220.220"
    "2620:119:35::35"
    "2620:119:53::53"
    # NextDNS
    "45.90.28.142"
    "45.90.30.142"
    "2a07:a8c0::63:e785"
    "2a07:a8c1::63:e785"
  ];
in
{
  services.dnsmasq = {
    enable = true;
    settings = {
      server = nameservers;
      dhcp-leasefile = false;
    };
  };

  networking.networkmanager.dns = "none";
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;
}
