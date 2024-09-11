---@diagnostic disable: missing-fields
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Issafalcon/neotest-dotnet',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-dotnet' {
          dap = {
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            args = { justMyCode = false },
            -- Enter the name of your dap adapter, the default value is netcoredbg
            adapter_name = 'coreclr',
          },
          -- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
          -- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
          custom_attributes = {
            xunit = { 'MyCustomFactAttribute' },
            nunit = { 'MyCustomTestAttribute' },
            mstest = { 'MyCustomTestMethodAttribute' },
          },
          -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
          dotnet_additional_args = {
            '--verbosity detailed',
          },
          -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
          -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
          --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
          discovery_root = 'project', -- Default
        },
      },
    }

    --Keymaps
    local neotest = require 'neotest'
    vim.keymap.set('n', '<C-t>o', neotest.summary.toggle)
    vim.keymap.set('n', '<C-t>r', neotest.run.run)
    vim.keymap.set('n', '<C-t>d', function()
      neotest.run.run { strategy = 'dap' }
    end)
    vim.keymap.set('n', '<C-t>l', neotest.run.run_last)
    vim.keymap.set('n', '<C-t>L', function()
      neotest.run.run_last { strategy = 'dap' }
    end)
    vim.keymap.set('n', '<C-t>f', function()
      neotest.run.run(vim.fn.expand '%')
    end)
    vim.keymap.set('n', '<C-t>s', neotest.run.stop)

    vim.keymap.set('n', '<C-t>i', function()
      vim.diagnostic.open_float()
    end)
    vim.keymap.set('n', '<C-t>p', neotest.output_panel.toggle)
    -- Innerhalb der Testsummary durch Klicken auf einen Test zu diesem bestimmten Test navigieren
    -- Über die Testsummary einen Teil des Testtrees laufen lassen
    -- Shortcut um alle Tests gleichzeitig laufen zu lassen
  end,
}
