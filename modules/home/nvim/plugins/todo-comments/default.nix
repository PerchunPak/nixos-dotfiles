# Highlight todo, notes, etc in comments
{
  programs.nixvim.plugins = {
    todo-comments = {
      enable = true;
      highlight.pattern = ".*<(KEYWORDS)";
      keymaps.todoTelescope.key = "<leader>st";
    };
  };
}
