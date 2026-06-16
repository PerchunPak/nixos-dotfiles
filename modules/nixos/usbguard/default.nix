{ pkgs, config, ... }:
{
  services.usbguard = {
    enable = config.my.gui.enable;
    IPCAllowedUsers = [ "perchun" ];
    rules = ''
      # my laptop devices
      allow with-connect-type "hardwired"
      allow id 1d6b:0002 serial "0000:05:00.3" name "xHCI Host Controller"      hash "4a4NgfdUaJO43rkCzmWRSeHHR/uUh5+SNsXnhosm9qs=" parent-hash "ldMchY4Tt4GPUYo30eNGvai+Fs/EdnVY3vMyxJUq4Nk=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 serial "0000:05:00.3" name "xHCI Host Controller"      hash "d+DNGWARDtv9nEK2ZvnNOCtFernuMu5/e/oZ7kCppqQ=" parent-hash "ldMchY4Tt4GPUYo30eNGvai+Fs/EdnVY3vMyxJUq4Nk=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0002 serial "0000:05:00.4" name "xHCI Host Controller"      hash "icotY3rI59mWiKsGxc59BGZZeBjfbuH0b4NUByj3cbQ=" parent-hash "tHvBfznK5rpQn+oa0PEEjHa29EAEvGyCcZixsfwA6W0=" with-interface 09:00:00 with-connect-type ""
      allow id 1d6b:0003 serial "0000:05:00.4" name "xHCI Host Controller"      hash "UbEoCZW8HT2ldc3qDeiK+IiQlGeaBC7F63681OwmKhI=" parent-hash "tHvBfznK5rpQn+oa0PEEjHa29EAEvGyCcZixsfwA6W0=" with-interface 09:00:00 with-connect-type ""
      allow id 1532:0557 serial "000000000001" name "Razer BlackShark V2 X USB" hash "vuU+eIS3z03wB5AYM8q0aMNczULRPsUx46i6jxay83c=" parent-hash "4a4NgfdUaJO43rkCzmWRSeHHR/uUh5+SNsXnhosm9qs=" with-interface { 01:01:00 01:02:00 01:02:00 01:02:00 01:02:00 01:02:00 03:00:00 } with-connect-type "hotplug"
      allow id 04f3:0c4f serial ""             name "ELAN:Fingerprint"          hash "Pk3ioTI8T2xGSho/LLCGJxR4A8R2R0t57/CdShy388I=" parent-hash "4a4NgfdUaJO43rkCzmWRSeHHR/uUh5+SNsXnhosm9qs=" with-interface ff:00:00 with-connect-type "hardwired"
      allow id 04ca:3802 serial "000000000"    name "Wireless_Device"           hash "8OQe3ZZjJcYjzRSXm1qI9BvuD1MjL9GjoJ7zq3WSV3M=" parent-hash "4a4NgfdUaJO43rkCzmWRSeHHR/uUh5+SNsXnhosm9qs=" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "hardwired"
      allow id 046d:c53f serial ""             name "USB Receiver"              hash "0CvpzR0LvcBGeSmIyAgYKqVIZgbnl1jeG4cNd09Fmsk=" parent-hash "icotY3rI59mWiKsGxc59BGZZeBjfbuH0b4NUByj3cbQ=" with-interface { 03:01:01 03:01:02 03:00:00 } with-connect-type "hotplug"
      allow id 04f2:b72b serial "200901010001" name "HD User Facing"            hash "cJCUEYZkouTwKxCVQxoTCFhDWySCdqafH1djQhtaahw=" parent-hash "icotY3rI59mWiKsGxc59BGZZeBjfbuH0b4NUByj3cbQ=" with-interface { 0e:01:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 fe:01:01 } with-connect-type "not used"

      # USB flash disk which implements a keyboard or a network interface
      reject with-interface all-of { 08:*:* 03:00:* }
      reject with-interface all-of { 08:*:* 03:01:* }
      reject with-interface all-of { 08:*:* e0:*:* }
      reject with-interface all-of { 08:*:* 02:*:* }
    '';
  };
}
