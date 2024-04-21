{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.filterMode = "fuzzy";
    };
  };
  my.persistence.files = [".config/lazygit/state.yml"];
}
