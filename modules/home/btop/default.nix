{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      base_10_sizes = true;
      swap_disk = false;
      net_iface = "enp9s0";
      disks_filter = "/ /boot";
    };
  };
}
