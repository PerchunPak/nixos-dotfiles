{channels, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      # If you save file with syntax errors, it will stop you from
      # typing for next ~0.5s. Which is really annoying
      notifyOnError = false;

      # see https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
      formatOnSave = ''
        function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end
      '';
      # WARN: Do not forget to add these to `programs.nixvim.extraPackages`
      formattersByFt = {
        nix = ["alejandra"];
        lua = ["stylua"];
        python = ["ruff_fix" "ruff_format"];
        javascript = ["prettierd"];
        "*" = ["codespell" "trim_whitespace"];
      };
    };

    extraPackages = with channels.unstable; [
      alejandra
      codespell
      prettierd
      ruff
      stylua
      gawk # trim_whitespace
    ];

    extraConfigLua = ''
      -- See https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    '';
  };
}
