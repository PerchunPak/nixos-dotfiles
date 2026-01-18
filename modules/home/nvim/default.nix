{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  module = lib.modules.importApply ../../../nvim inputs;
  wrapper = inputs.wrappers.lib.evalModule module;
  nvim = wrapper.config.wrap { inherit pkgs; };
  testNvim = wrapper.config.wrap {
    inherit pkgs;
    isTest = true;
  };
in
{
  home.packages = [
    nvim
    testNvim
  ];

  my.persistence.directories = [
    ".local/state/nvim/dbee"
    ".local/state/nvim/shada"
    ".local/state/nvim/undo"
    ".local/share/nvim/devdocs"
  ];
}
