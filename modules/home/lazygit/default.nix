{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.filterMode = "fuzzy";
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };
  my.persistence.files = [ ".config/lazygit/state.yml" ];
}
