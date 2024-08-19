return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        smart_indent_cap = false,
        priority = 1,
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
}
