{
  pkgs,
  config,
  ...
}: {
  programs.fish.plugins = [
    {
      name = "tide";
      src = pkgs.fishPlugins.tide.src;
    }
  ];

  xdg.configFile."fish/fish_variables.example".source = ./fish_variables.fish;

  # Copy fish_variables if not exists, tide saves there cache
  my.setup-stuff.fish-variables = {
    enable = true;
    command = ''
      ${pkgs.coreutils}/bin/cp -n ${config.xdg.configHome}/fish/fish_variables.example ${config.xdg.configHome}/fish/fish_variables
    '';
  };
}
