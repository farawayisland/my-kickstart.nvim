-- [[ Window management ]]
-- In normal- and visual-modes
--- Window-closing
vim.keymap.set({ 'n', 'x' }, '<Leader>wc', '<Cmd>clo<CR>', { desc = 'Close current window' })

--- Window-quitting
vim.keymap.set({ 'n', 'x' }, '<Leader>qw', '<Cmd>q<CR>', { desc = 'Quit current window' })

--- Window-switching
vim.keymap.set({ 'n', 'x' }, '<Leader>wb', '<C-w><C-p>', { desc = 'Switch between current and last window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wn', '<C-w>w', { desc = 'Go to next window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wp', '<C-w>W', { desc = 'Go to previous window' })

-- vim: et sts=2 sw=2 ts=2
