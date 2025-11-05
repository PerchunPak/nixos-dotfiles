{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.filterMode = "fuzzy";
      git = {
        pagers = [
          {
            colorArg = "always";
            pager = "delta --dark --paging=never";
          }
        ];
        overrideGpg = true;
        mainBranches = [
          "master"
          "main"
          "develop"
          "dev"
        ];
      };
    };
  };
  my.persistence.files = [ ".config/lazygit/state.yml" ];
}
