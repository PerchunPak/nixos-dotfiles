{
  programs.nixvim.plugins = {
    undotree = {
      enable = true;
      settings = {
        DiffpanelHeight = 0;
        SetFocusWhenToggle = 1;
      };
    };
  };

  my = {
    nvim.keymaps = [
      [
        "n"
        "<leader>u"
        ":UndotreeToggle<CR>"
        { options.desc = "Open [U]ndo tree"; }
      ]
    ];
    persistence.directories = [ ".local/state/nvim/undo" ];
  };
}
