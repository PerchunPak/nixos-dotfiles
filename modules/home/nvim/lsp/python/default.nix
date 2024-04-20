{
  programs.nixvim.plugins = {
    lsp.servers = {
      pylsp = {
        enable = true;
        settings.plugins = {
          rope.enabled = true;
          rope_autoimport.enabled = true;
          pylsp_mypy.enabled = true;

          mccabe.enabled = false; # complexity checking
          memestra.enabled = true; # deprecated functions

          black = {
            enabled = true;
            line_length = 120;
          };
          isort.enabled = true;
          ruff.enabled = true;
        };
      };
    };
  };
}
