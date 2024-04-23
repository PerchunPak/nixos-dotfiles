{ pkgs, options, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [ e2fsprogs ]);

  environment.systemPackages = with pkgs; [ steam-run ];
}
