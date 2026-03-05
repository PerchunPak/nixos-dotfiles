{ ... }:
final: prev: {
  zellijPlugins = prev.zellijPlugins // {
    vim-zellij-navigator = final.zellijPlugins.wrap (
      prev.zellijPlugins.vim-zellij-navigator.unwrapped.overrideAttrs (old: {
        patches = old.patches or [ ] ++ [
          ./custom-cmds.patch
        ];
      })
    );
  };
}
