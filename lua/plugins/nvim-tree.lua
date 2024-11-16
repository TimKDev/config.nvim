return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 40,
      },
      hijack_cursor = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      filters = {
        dotfiles = false,
      },
      renderer = {
        icons = {
          glyphs = {
            default = '', -- default file icon (e.g., plain text file)
            symlink = '',
            git = {
              unstaged = '★',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '✗',
              deleted = '',
              ignored = '◌',
            },
            folder = {
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
            },
          },
        },
      },
    }

    local api = require 'nvim-tree.api'
    vim.keymap.set('n', '<leader>i', api.tree.open)
    vim.keymap.set('n', '<C-m>m', api.tree.toggle)
    vim.keymap.set('n', '<C-m>n', api.tree.collapse_all)
  end,
}
