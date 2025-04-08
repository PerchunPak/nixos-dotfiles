return {
  'conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>bb',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Buffer [F]ormat',
    },
    {
      '<leader>bf',
      function()
        vim.g.disable_autoformat = true
      end,
      mode = 'n',
      desc = 'Disable auto-format',
    },
    {
      '<leader>bd',
      function()
        vim.b.disable_autoformat = true
      end,
      mode = 'n',
      desc = 'Disable auto-format for this buffer',
    },
    {
      '<leader>bF',
      function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end,
      mode = 'n',
      desc = 'Enable auto-format',
    },
  },
  after = function()
    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        local disabled_projects = {
          ['/home/perchun/dev/h4folks-frontend'] = true,
        }
        if disabled_projects[vim.fn.getcwd()] then
          return { lsp_fallback = 'prefer' }
        end

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_fallback = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        nix = { 'nixfmt' },
        lua = { 'stylua' },
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        rust = { 'rustfmt' },
        ['*'] = { 'codespell', 'trim_whitespace' },
      },
    }

    require('conform').formatters.codespell = {
      prepend_args = {
        '-L',
        -- codespell please stop bullying me 😭
        -- https://github.com/NixOS/nixpkgs/pull/376366#discussion_r1928723734
        'evesdropper,'
          -- rust
          .. 'crate,',
      },
    }
  end,
}
