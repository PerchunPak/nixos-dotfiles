{
  config = {
    nix = {
      distributedBuilds = true;

      # Nix will instruct remote build machines to use their own binary substitutes if available.
      # In practical terms, this means that remote hosts will fetch as many build dependencies as
      # possible from their own substitutes (e.g, from cache.nixos.org), instead of waiting for this
      # host to upload them all. This can drastically reduce build times if the network connection
      # between this computer and the remote build host is slow.
      settings.builders-use-substitutes = true;

      buildMachines = [
        {
          hostName = "darwin-build-box.nix-community.org";
          protocol = "ssh-ng";
          sshUser = "perchun";
          sshKey = "/home/perchun/.ssh/id_ed25519";
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtNSGhsY243ZlVwVXVpT0ZlSWhEcUJ6Qk5Gc2JOcXErTnB6dUdYM2U2enYgCg";
          maxJobs = 8; # 10 cores
          systems = [
            "aarch64-darwin"
            "x86_64-darwin"
          ];
          supportedFeatures = [ "big-parallel" ];
        }
        {
          hostName = "aarch64-build-box.nix-community.org";
          protocol = "ssh-ng";
          sshUser = "perchun";
          sshKey = "/home/perchun/.ssh/id_ed25519";
          publicHostKey = "YWFyY2g2NC1idWlsZC1ib3gubml4LWNvbW11bml0eS5vcmcgc3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUc5dXlmaHlsaStCUnRrNjR5K25pcXRiK3NLcXVSR0daODdmNFlSYzhFRTEK";
          maxJobs = 40; # 80 cores
          systems = [ "aarch64-linux" ];
          supportedFeatures = [
            "uid-range"
            "benchmark"
            "big-parallel"
            "nixos-test"
            "gccarch-armv8-a"
          ];
        }
      ];
    };
  };
}
