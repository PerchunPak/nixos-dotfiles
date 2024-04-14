{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      meslo-lgs-nf
    ];
  };
}
