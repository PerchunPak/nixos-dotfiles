return {
  'undotree',
  cmd = { 'UndotreeToggle' },
  keys = {
    { '<leader>u', ':UndotreeToggle<CR>' },
  },
  after = function()
    vim.g.undotree_DiffpanelHeight = 0
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
