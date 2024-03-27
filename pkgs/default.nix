# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: let
  callPythonPackage = pkgs.lib.callPackageWith (pkgs // pkgs.python3Packages // {pydantic_1 = pkgs.python3Packages.pydantic;});
in {
  my = {
    # example = pkgs.callPackage ./example { };
    cruft = callPythonPackage ./cruft.nix {pytest_7 = pkgs.python3Packages.pytest;};
  };
}
