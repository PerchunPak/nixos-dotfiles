{ pkgs, options, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries =
      options.programs.nix-ld.libraries.default
      ++ (with pkgs; [
        e2fsprogs
        gcc
        libgcc
      ]);
  };

  environment.systemPackages = with pkgs; [ steam-run ];
}
