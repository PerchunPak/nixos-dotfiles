return {
  { 'nvim-dap-ui', on_require = 'dapui' },
  { 'nvim-dap-python', on_require = 'dap-python' },
  { 'nvim-nio', on_require = 'nio' },
  {
    'nvim-dap',
    -- stylua: ignore
    keys = {
      { '<F5>',      function() require('dap').continue() end,                                            desc = 'Debug: Start/Continue' },
      { '<F1>',      function() require('dap').step_into() end,                                           desc = 'Debug: Step Into' },
      { '<F2>',      function() require('dap').step_over() end,                                           desc = 'Debug: Step Over' },
      { '<F3>',      function() require('dap').step_out() end,                                            desc = 'Debug: Step Out' },
      { '<leader>b', function() require('dap').toggle_breakpoint() end,                                   desc = 'Debug: Toggle Breakpoint' },
      { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
      { '<F7>',      function() require('dapui').toggle() end,                                            desc = 'Debug: See last session result.', },
    },
    after = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Change breakpoint icons
      vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#f38ba8' })
      vim.api.nvim_set_hl(0, 'DapStop', { fg = '#f9e2af' })
      local breakpoint_icons = {
        Breakpoint = '',
        BreakpointCondition = '',
        BreakpointRejected = '',
        LogPoint = '',
        Stopped = '',
      }
      for type, icon in pairs(breakpoint_icons) do
        local tp = 'Dap' .. type
        local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install python specific config
      require('dap-python').setup 'python'
      require('dap-python').test_runner = 'pytest'
    end,
  },
}
