{
  programs.starship = {
    enable = true;
    enableFishIntegration = false;

    settings = {
      add_newline = false;
    } // builtins.fromTOML (builtins.readFile ./config.toml);
  };
}
