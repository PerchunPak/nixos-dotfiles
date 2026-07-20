{
  services.cliproxyapi = {
    enable = true;
    settings = {
      port = 8317;
      remote-management.secret-key = "$2a$10$iEauGP9r6pvcbz7KnVbpAOYgiHCK2Nd2UUx1MfAxUyh4CUeL.PixC";
    };
  };

  my.persistence.directories = [
    "/var/lib/cliproxyapi"
  ];
}
