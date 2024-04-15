{
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      registrations = {
        "<leader>c" = {
          name = "[C]ode";
          _ = "which_key_ignore";
        };
        "<leader>d" = {
          name = "[D]ocument";
          _ = "which_key_ignore";
        };
        "<leader>r" = {
          name = "[R]ename";
          _ = "which_key_ignore";
        };
        "<leader>s" = {
          name = "[S]earch";
          _ = "which_key_ignore";
        };
        "<leader>w" = {
          name = "[W]orkspace";
          _ = "which_key_ignore";
        };
      };
    };
  };
}
