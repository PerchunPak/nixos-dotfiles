{
  programs.waybar = {
    settings.mainBar = builtins.fromJSON (builtins.readFile ./config.json);
    style = builtins.readFile ./style.css;
  };
}
