-- ~/.config/nvims/kickstart/lua/keymaps/tab-management.lua
-- [[ Tab management ]]
-- In normal and visual modes
--- Window-closing
vim.keymap.set({ 'n', 'x' }, '<Leader>tc', '<Cmd>tabc<CR>', { desc = 'Close current tab' })

--- Window-switching
vim.keymap.set({ 'n', 'x' }, '<Leader>tb', 'g<Tab>', { desc = 'Switch between current and last tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>tn', '<Cmd>tabn<CR>', { desc = 'Go to next tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>tp', '<Cmd>tabp<CR>', { desc = 'Go to previous tab' })

-- vim: et sts=2 sw=2 ts=2
