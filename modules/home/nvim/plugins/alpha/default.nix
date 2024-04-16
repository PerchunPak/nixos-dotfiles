# Welcome screen
{
  programs.nixvim.plugins = {
    alpha = {
      enable = true;
      theme = "startify";
    };
  };

  my.persistence.directories = [".local/state/nvim/shada"];
}
