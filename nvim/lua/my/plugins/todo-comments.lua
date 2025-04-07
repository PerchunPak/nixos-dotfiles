return {
  'todo-comments.nvim',
  event = 'VimEnter',
  after = function()
    require('todo-comments').setup {
      signs = false,
      highlight = { pattern = '.*<(KEYWORDS)' },
    }
  end,
}
