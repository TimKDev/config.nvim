return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    require('dapui').setup()

    dap.adapters.coreclr = {
      type = 'executable',
      command = '/home/tim/Tools/dotnet/netcoredbg/netcoredbg',
      args = { '--interpreter=vscode' },
    }

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/net8.0', 'file')
        end,
      },
    }

    -- Define Keymaps
    vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<space>gb', dap.run_to_cursor)
    vim.keymap.set('n', '<space>?', function()
      require('dapui').eval(nil, { enter = true })
    end)
    vim.keymap.set('n', '<F1>', dap.continue)
    vim.keymap.set('n', '<F2>', dap.step_into)
    vim.keymap.set('n', '<F3>', dap.step_over)
    vim.keymap.set('n', '<F4>', dap.step_out)
    vim.keymap.set('n', '<F5>', dap.step_back)
    vim.keymap.set('n', '<F12>', dap.restart)
    vim.keymap.set('n', '<F10>', dap.disconnect)

    -- Define Eventlisteners:
    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
