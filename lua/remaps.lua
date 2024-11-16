local function noremap(original_key, new_key, mode)
  local selectedMode = mode or 'n'
  vim.api.nvim_set_keymap(selectedMode, original_key, new_key, { noremap = true, silent = true })
end

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>m', vim.diagnostic.open_float, { desc = 'Open diagnostic message' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Move normally between wrapped lines
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Fixes pasting after visual selection.
vim.keymap.set('v', 'p', '"_dP')

-- Indenting in visual mode (tab/shift+tab)
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Move to the end of yanked text after yank and paste
vim.cmd 'vnoremap <silent> y y`]'
vim.cmd 'vnoremap <silent> p p`]'
vim.cmd 'nnoremap <silent> p p`]'

--Opens the explorer. Faster than :Ex
--vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

noremap('<C-d>', '<C-d>zz')
noremap('<C-u>', '<C-u>zz')
noremap('n', 'nzzzv')
noremap('N', 'Nzzzv')
noremap('<leader>p', '"_dP', 'v')
noremap('<C-c>', '<Esc>')
noremap('<C-w>a', ':bprevious<CR>')
noremap('<C-w>y', ':bnext<CR>')
noremap('<C-w>p', ':tabclose<CR>')
noremap('<C-w>z', ':tabo<CR>')
