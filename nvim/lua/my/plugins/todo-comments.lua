return {
  'todo-comments.nvim',
  event = 'VimEnter',
  after = function()
    require('todo-comments').setup {
      signs = false,
      highlight = { pattern = '.*<(KEYWORDS)' },
    }
  end,
  keys = {
    {
      'n',
      '<leader>ft',
      function()
        local keywords = require('todo-comments.config').keywords

        local aslist = {}
        local n = 0
        for _, v in pairs(keywords) do
          if v ~= 'NOTE' then
            n = n + 1
            aslist[n] = v
          end
        end

        vim.cmd.TodoTelescope { 'keywords=' .. table.concat(aslist, ',') }
      end,
      { desc = 'Search [T]odos' },
    },
  },
  {
    'n',
    '<leader>fT',
    vim.cmd.TodoTelescope,
    { desc = 'Search all [T]odos' },
  },
}
