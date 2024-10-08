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
          # Darwin build box
          hostName = "darwin-build-box.nix-community.org";
          sshUser = "perchun";
          sshKey = "/home/perchun/.ssh/id_ed25519";
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUZ6OEZYU1ZFZGY4RnZETWZib3hoQjVWalNlN3kyV2dTYTA5cTFMNHQwOTkgCg";
          maxJobs = 32;
          systems = [
            "aarch64-darwin"
            "x86_64-darwin"
          ];
          supportedFeatures = [
            "apple-virt"
            "big-parallel"
          ];
        }
      ];
    };
  };
}
