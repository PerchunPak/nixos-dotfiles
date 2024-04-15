{
  lib,
  config,
  ...
}: let
  cfg = config.my.nvim;
in {
  options = {
    my.nvim = {
      keymaps = lib.mkOption {
        # [ "mode" "key" "action" {additional} ]
        type = with lib.types; listOf (listOf (either str attrs));
      };
    };
  };

  config = {
    programs.nixvim.keymaps = lib.forEach cfg.keymaps (
      keymap:
        {
          mode = builtins.elemAt keymap 0;
          key = builtins.elemAt keymap 1;
          action = builtins.elemAt keymap 2;
        }
        // (
          if (builtins.length keymap) >= 4
          then builtins.elemAt keymap 3
          else {}
        )
    );

    my.nvim.keymaps = [
      # Set highlight on search, but clear on pressing <Esc> in normal mode
      ["n" "<Esc>" "<cmd>nohlsearch<CR>"]
      # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
      # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
      # is not what someone will guess without a bit more experience.
      ["t" "<Esc><Esc>" "<C-\\><C-n>" {options.desc = "Exit terminal mode";}]
      # Disable arrow keys in normal mode
      ["n" "<left>" "<cmd>echo \"Use h to move!!\"<CR>"]
      ["n" "<right>" "<cmd>echo \"Use l to move!!\"<CR>"]
      ["n" "<up>" "<cmd>echo \"Use k to move!!\"<CR>"]
      ["n" "<down>" "<cmd>echo \"Use j to move!!\"<CR>"]
      # Keybinds to make split navigation easier.
      ["n" "<C-h>" "<C-w><C-h>" {options.desc = "Move focus to the left window";}]
      ["n" "<C-l>" "<C-w><C-l>" {options.desc = "Move focus to the right window";}]
      ["n" "<C-j>" "<C-w><C-j>" {options.desc = "Move focus to the lower window";}]
      ["n" "<C-k>" "<C-w><C-k>" {options.desc = "Move focus to the upper window";}]
    ];
  };
}
