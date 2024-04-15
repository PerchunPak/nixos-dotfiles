{
  programs.nixvim.plugins = {
    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          smart_indent_cap = false;
          priority = 1;
        };
        scope = {
          show_start = false;
          show_end = false;
        };
      };
    };
  };
}
