{ ... }:
final: prev: {
  vimPlugins = prev.vimPlugins // {
    todo-comments-nvim = prev.vimPlugins.todo-comments-nvim.overrideAttrs (old: {
      patches = old.patches or [ ] ++ [
        # https://github.com/folke/todo-comments.nvim/pull/381
        (final.fetchpatch {
          url = "https://github.com/folke/todo-comments.nvim/commit/dbe224bc0bd4378425cbd65602386f5846bd7354.diff?full_index=1";
          hash = "sha256-xgdBZKmgZYRaq84I2g2Xk94TacgIo8oh3ZBROWyFk0w=";
        })
      ];
    });
  };
}
