-- ~/.config/nvims/kickstart/lua/keymaps/fold-management.lua
-- [[ Fold management ]]
-- In normal- and visual-modes
--- Fold-closing
vim.keymap.set({ 'n', 'x' }, '<Leader>fc', 'zc', { desc = 'Close one fold under the cursor' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fca', 'zM', { desc = 'Close all folds' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fcr', 'zC', { desc = 'Close all folds under the cursor recursively' })

--- Fold-opening
vim.keymap.set({ 'n', 'x' }, '<Leader>fo', 'zo', { desc = 'Open one fold under the cursor' })
vim.keymap.set({ 'n', 'x' }, '<Leader>foa', 'zR', { desc = 'Open all folds' })
vim.keymap.set({ 'n', 'x' }, '<Leader>for', 'zO', { desc = 'Open all folds under the cursor recursively' })

--- Fold-toggling
vim.keymap.set({ 'n', 'x' }, '<Leader>ft', 'za', { desc = 'Toggle one fold under the cursor' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ftr', 'zA', { desc = 'Toggle all folds under the cursor recursively' })

-- vim: et sts=2 sw=2 ts=2
