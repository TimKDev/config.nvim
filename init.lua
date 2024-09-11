require 'options'
require 'remaps'
require 'autocommands'

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth',
  'christoomey/vim-tmux-navigator',
  require 'plugins.gitsigns',
  require 'plugins.which-key',
  require 'plugins.telescope',
  require 'plugins.lazydev',
  require 'plugins.luvit-meta',
  require 'plugins.lspconfig',
  require 'plugins.conform',
  require 'plugins.nvim-cmp',
  require 'plugins.night-owl',
  require 'plugins.todo-comments',
  require 'plugins.mini-vim',
  require 'plugins.treesitter',
  require 'plugins.indent_line',
  require 'plugins.harpoon',
  require 'plugins.nvim-dap',
  require 'plugins.nvim-tree',
  require 'plugins.nvim-web-devicons',
  require 'plugins.nvim-neotest',
  require 'plugins.transparent',
  require 'plugins.vim-fugitive',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
