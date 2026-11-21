{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    my.amdgpu = {
      enable = lib.mkEnableOption "AMD GPU";
    };
  };
  config = lib.mkIf config.my.amdgpu.enable {
    hardware.graphics.enable = true;

    # enable fan control
    hardware.amdgpu.overdrive.enable = true;

    # ROCm builds of PyTorch (and other pip wheels) bundle their own libdrm,
    # which looks up marketing names of GPUs in this hardcoded path. Without
    # it, they print "(null): No such file or directory" on every start.
    systemd.tmpfiles.rules = [
      "L+ /opt/amdgpu/share/libdrm/amdgpu.ids - - - - ${pkgs.libdrm}/share/libdrm/amdgpu.ids"
    ];
  };
}
