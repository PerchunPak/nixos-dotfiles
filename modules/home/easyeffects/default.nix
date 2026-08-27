{
  services.easyeffects = {
    enable = true;
    preset = {
      input = "main";
    };
    extraPresets = {
      main = builtins.fromJSON (builtins.readFile ./preset.json);
    };
  };
}
