return {
  'L3MON4D3/LuaSnip',
  version = 'v2.3',
  build = 'make install_jsregexp',
  config = function()
    local ls = require 'luasnip'

    vim.keymap.set({ 'i', 's' }, '<C-J>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-K>', function()
      ls.jump(-1)
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-l>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })

    -- $TM_FILENAME gives the current filename in lua snippets.
    -- snippets files can also be organized using folders like csharp or html with e.g. delimiters.lua files in them
    require('luasnip.loaders.from_lua').load { paths = { '~/.config/nvim/LuaSnip/' } }
  end,
}
