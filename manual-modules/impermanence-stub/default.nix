{ lib, inputs, ... }:
# This is a stub module, that declares impermanence's options,
# without doing anything.
{
  imports = [
    (lib.modules.mkAliasOptionModule [ "my" "persistence" ] [ "environment" "persistence" "/persist" ])
  ];

  options = {
    environment.persistence = lib.mkOption {
      default = { };
      type = lib.types.anything;
    };
  };

  config = {
    # also import home-manager module, which is a stub as well
    home-manager.sharedModules = [
      "${inputs.impermanence}/home-manager.nix"
      { home._nixosModuleImported = true; }
    ];
  };
}
