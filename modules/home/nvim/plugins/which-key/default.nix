{
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      # TODO: re-enable when https://github.com/nix-community/nixvim/pull/1927 will be merged

      # registrations = {
      #   "<leader>c" = {
      #     name = "[C]ode";
      #     _ = "which_key_ignore";
      #   };
      #   "<leader>d" = {
      #     name = "[D]ocument";
      #     _ = "which_key_ignore";
      #   };
      #   "<leader>r" = {
      #     name = "[R]ename";
      #     _ = "which_key_ignore";
      #   };
      #   "<leader>s" = {
      #     name = "[S]earch";
      #     _ = "which_key_ignore";
      #   };
      #   "<leader>w" = {
      #     name = "[W]orkspace";
      #     _ = "which_key_ignore";
      #   };
      # };
    };
  };
}
