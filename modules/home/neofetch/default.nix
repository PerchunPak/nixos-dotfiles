{ pkgs, ... }:
{
  programs.hyfetch = {
    enable = true;
    package = pkgs.hyfetch;
    settings = {
      preset = "transgender"; # yes, questions?
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.5;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      backend = "neofetch";
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };

  xdg.configFile."neofetch/config.conf".source = ./neofetch.conf;

  # add alias in case if some normie will want to run neofetch
  programs.fish.shellAliases = {
    neofetch = "neowofetch";
  };

  # neofetch needs this to display GPU
  home.packages = with pkgs; [ pciutils ];
}
