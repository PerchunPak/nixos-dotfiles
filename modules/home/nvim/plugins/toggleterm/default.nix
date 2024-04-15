{
  programs.nixvim.plugins = {
    toggleterm = {
      enable = true;
      settings = {
        open_mapping = "[[<c-\\>]]";
        shade_terminals = false;
        terminal_mappings = true;
        # for system reproducibility reasons
        persist_size = false;
        persist_mode = false;
      };
    };
  };
}
