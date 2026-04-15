-- ~/.config/nvims/kickstart/lua/keymaps/troubleshooting.lua
-- [[ Troubleshooting ]]
-- In normal- and visual-modes
--- Healthchecks
vim.keymap.set({ 'n', 'x' }, '<Leader>ch', '<Cmd>che<CR>', { desc = 'Run all healthchecks' })

--- Quickfixes
vim.keymap.set({ 'n', 'x' }, '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uick[f]ix list' })

-- vim: et sts=2 sw=2 ts=2
