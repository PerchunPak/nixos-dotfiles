# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: let
  callPythonPackage = pkgs.lib.callPackageWith (pkgs // pkgs.python3Packages // {pydantic_1 = pkgs.python3Packages.pydantic;});
in {
  my = rec {
    # example = pkgs.callPackage ./example { };
    gh-copilot = pkgs.callPackage ./gh-copilot.nix {};
    cruft = callPythonPackage ./cruft.nix {inherit examples;};
    examples = callPythonPackage ./python-examples {};
  };
}
