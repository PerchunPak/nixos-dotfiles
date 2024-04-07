# This file defines overlays
{inputs, ...}: rec {
  # This is a list of all overlays to add
  all = [
    additions
    modifications
    unstable-packages

    inputs.nur.overlay
    # for pylyzer to work, see https://github.com/NixOS/nixpkgs/issues/295735#issuecomment-2015676505
    inputs.rust-overlay.overlays.default
  ];

  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # for pylyzer to work, see https://github.com/NixOS/nixpkgs/issues/295735#issuecomment-2015676505
    pylyzer = prev.pylyzer.override {
      rustPlatform = final.makeRustPlatform {
        rustc = final.pkgs.rust-bin.stable."1.75.0".default;
        cargo = final.pkgs.cargo;
      };
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      overlays = all;
      config.allowUnfree = true;
    };
  };
}
