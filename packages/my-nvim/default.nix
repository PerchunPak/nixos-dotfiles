{
  inputs,
  pkgs,
  lib,
}:
let
  module = lib.modules.importApply ../../nvim inputs;
  wrapper = inputs.wrappers.lib.evalModule module;
in
lib.lazyDerivation {
  meta.mainProgram = "nvim";
  outputs = [
    "out"
    "debug"
  ];
  derivation = wrapper.config.wrap { inherit pkgs; };
}
