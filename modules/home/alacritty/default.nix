{ ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        opacity = 0.7;
        padding.x = 3;
        padding.y = 3;
      };
      font = {
        normal = {
          family = "MesloLGS Nerd Font";
          style = "Regular";
        };
        size = 13.0;
      };
      mouse.hide_when_typing = true;
    };
  };
}
