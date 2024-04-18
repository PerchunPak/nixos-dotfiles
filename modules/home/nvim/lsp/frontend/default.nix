{
  programs.nixvim.plugins = {
    lsp.servers = {
      tsserver.enable = true;
      svelte.enable = true;
    };
  };
}
