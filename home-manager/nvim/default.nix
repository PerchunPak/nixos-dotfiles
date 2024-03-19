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
    enableMan = false;
    extraConfigLua = builtins.readFile ./config.lua;
    extraPackages = with pkgs.unstable; [
      stylua
      ruff
      prettierd
      codespell
      gawk # trim_whitespace
      alejandra
    ];
  };
}
