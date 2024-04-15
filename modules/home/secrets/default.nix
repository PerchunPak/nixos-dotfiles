{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age.identityPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
  home.packages = [
    inputs.agenix.packages.x86_64-linux.default
  ];
}
