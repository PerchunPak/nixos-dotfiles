return {
  'mbbill/undotree',
  cmd = { 'UndotreeToggle' },
  config = function()
    vim.g.undotree_DiffpanelHeight = 0
    vim.g.undotree_SetFocusWhenToggle = 1

    vim.keymap.set(
      'n',
      '<leader>u',
      vim.cmd.UndotreeToggle,
      { options = {
        desc = 'Open [U]ndo tree',
      } }
    )
  end,
}
