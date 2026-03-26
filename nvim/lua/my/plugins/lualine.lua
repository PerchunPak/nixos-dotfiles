return {
  'lualine.nvim',
  after = function()
    require('lualine').setup {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_b = {
          'branch',
          {
            function()
              local clients = vim.lsp.get_clients()
              return string.rep('+', #clients)
            end,
            padding = { left = 0, right = 1 },
          },
        },
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = { 'filetype' },
        lualine_y = {},
      },
      inactive_sections = {
        lualine_a = { 'searchcount' },
        lualine_b = { 'lsp_status' },
        lualine_c = {
          { 'filename', path = 3 },
        },
        lualine_x = { 'filetype', 'location' },
      },
    }
  end,
}
