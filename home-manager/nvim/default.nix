{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # overwrite nixpkgs with unstable branch
    ({...} @ args: (inputs.nixvim.homeManagerModules.nixvim (args // {pkgs = pkgs.unstable;})))

    ./keymaps.nix
    ./options.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    extraConfigLua = builtins.readFile ./config.lua;
  };
}
