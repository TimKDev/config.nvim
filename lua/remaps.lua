local function noremap(original_key, new_key, mode)
  local selectedMode = mode or 'n'
  vim.api.nvim_set_keymap(selectedMode, original_key, new_key, { noremap = true, silent = true })
end

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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

--Opens the explorer. Faster than :Ex
--vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

noremap('<C-d>', '<C-d>zz')
noremap('<C-u>', '<C-u>zz')
noremap('n', 'nzzzv')
noremap('N', 'Nzzzv')
noremap('<leader>p', '"_dP', 'v')
noremap('<C-c>', '<Esc>')
