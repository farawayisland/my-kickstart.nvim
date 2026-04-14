-- ~/.config/nvims/kickstart/lua/keymaps/basic.lua
-- [[ Basic keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<Cmd>noh<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal- and visual-modes
vim.keymap.set({ 'n', 'x' }, '<Down>', '<Cmd>echo "Use j to move!"<CR>')
vim.keymap.set({ 'n', 'x' }, '<Left>', '<Cmd>echo "Use h to move!"<CR>')
vim.keymap.set({ 'n', 'x' }, '<Right>', '<Cmd>echo "Use l to move!"<CR>')
vim.keymap.set({ 'n', 'x' }, '<Up>', '<Cmd>echo "Use k to move!"<CR>')

-- Keybinds to make split navigation easier.
--  Use Ctrl-<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set({ 'n', 'x' }, '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 'x' }, '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 'x' }, '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n', 'x' }, '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set({ 'n', 'x' }, '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
-- vim.keymap.set({ 'n', 'x' }, '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
-- vim.keymap.set({ 'n', 'x' }, '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })
-- vim.keymap.set({ 'n', 'x' }, '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })

-- vim: et sts=2 sw=2 ts=2
