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
    clipboard.providers.wl-copy.enable = true;
    extraConfigLua = builtins.readFile ./config.lua;
    extraPackages = with pkgs.unstable; [
      # For conform-nvim
      alejandra
      codespell
      prettierd
      ruff
      stylua
      gawk # trim_whitespace
    ];
  };
}
