{
  inputs,
  pkgs,
  lib,
}:
let
  module = lib.modules.importApply ../../nvim inputs;
  wrapper = inputs.wrappers.lib.evalModule module;
in
wrapper.config.wrap { inherit pkgs; }
