{pkgs, ...}: {
  # use latest kernel because i can
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
}
