{
  programs.nixvim = {
    colorschemes.catppuccin.enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      transparent_enabled = true;
    };
    opts = {
      number = true;
      relativenumber = true;
      mouse = ""; # completely disable mouse
      showmode = false; # Don't show the mode, since it's already in status line
      breakindent = true;
      undofile = true; # Save undo history
      # Case-insensitive searching UNLESS \C or capital in search
      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";
      # Decrease update time
      updatetime = 250;
      timeoutlen = 300;
      # Configure how new splits should be opened
      splitright = true;
      splitbelow = true;
      # Sets how neovim will display certain whitespace in the editor.
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      # Preview substitutions live, as you type!
      inccommand = "split";

      cursorline = true;
      # Minimal number of screen lines to keep above and below the cursor.
      scrolloff = 10;

      hlsearch = true;
      splitkeep = "cursor";
    };
  };
}
