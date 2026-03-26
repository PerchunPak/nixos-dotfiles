--- @param trunc_width number truncates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number? hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- @param reverse boolean adds ellipsis to the start, instead of the end
--- return function that can format the component accordingly
function trunc(trunc_width, trunc_len, hide_width, no_ellipsis, reverse)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ''
    elseif
      trunc_width
      and trunc_len
      and win_width < trunc_width
      and #str > trunc_len
    then
      if reverse then
        return (no_ellipsis and '' or '...') .. str:sub(#str - trunc_len, #str)
      else
        return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
      end
    end
    return str
  end
end

return {
  'lualine.nvim',
  after = function()
    require('lualine').setup {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              local win_width = vim.fn.winwidth(0)
              if win_width < 80 then
                return str:sub(1, 1)
              end
              return str
            end,
          },
        },
        lualine_b = {
          {
            'branch',
            fmt = trunc(100, 13, 60, false, true),
            padding = { left = 1, right = 0 },
          },
          {
            function()
              local clients = vim.lsp.get_clients()
              return string.rep('+', #clients)
            end,
          },
        },
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = {
          {
            'filetype',
            fmt = function(str)
              local win_width = vim.fn.winwidth(0)
              if win_width < 100 then
                return ''
              end
              return str
            end,
          },
        },
        lualine_y = {},
      },
      inactive_sections = {
        lualine_a = { 'searchcount' },
        lualine_b = {},
        lualine_c = {
          { 'filename', path = 3 },
        },
        lualine_x = { 'filetype', 'location' },
      },
    }
  end,
}
