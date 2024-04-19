{
  programs.nixvim.plugins = {
    lsp.servers = {
      pylsp = {
        enable = true;
        settings.plugins = {
          pylsp_mypy.enabled = true;
          black = {
            enabled = true;
            line_length = 120;
          };
          isort.enabled = true;
          rope.enabled = true;
          rope_autoimport.enabled = true;
          ruff.enabled = true;
        };
      };
    };
  };
}
