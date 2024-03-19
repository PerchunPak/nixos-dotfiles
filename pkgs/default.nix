# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  my = {
    # example = pkgs.callPackage ./example { };
    gh-copilot = pkgs.callPackage ./gh-copilot.nix {};
  };
}
