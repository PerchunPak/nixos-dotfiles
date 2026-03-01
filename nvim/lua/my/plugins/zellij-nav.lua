return {
  'zellij-nav.nvim',
  event = 'DeferredUIEnter',
  keys = {
    {
      '<c-h>',
      '<cmd>ZellijNavigateLeftTab<cr>',
      { silent = true, desc = 'Move focus to the right window' },
    },
    {
      '<c-j>',
      '<cmd>ZellijNavigateDown<cr>',
      { silent = true, desc = 'Move focus to the lower window' },
    },
    {
      '<c-k>',
      '<cmd>ZellijNavigateUp<cr>',
      { silent = true, desc = 'Move focus to the upper window' },
    },
    {
      '<c-l>',
      '<cmd>ZellijNavigateRightTab<cr>',
      { silent = true, desc = 'Move focus to the left window' },
    },
  },
  after = function()
    require('zellij-nav').setup()

    vim.api.nvim_create_autocmd('VimLeave', {
      pattern = '*',
      command = 'silent !zellij action switch-mode normal',
    })
  end,
}
