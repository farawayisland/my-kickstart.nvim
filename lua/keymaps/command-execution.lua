-- ~/.config/nvims/kickstart/lua/keymaps/command-execution.lua
-- [[ Command execution ]]
-- In normal- and visual-modes
--- Shell-command execution
vim.keymap.set({ 'n', 'x' }, '<Leader>z', ':<C-u>!', { desc = "Execute command with 'shell'" })

-- vim: et sts=2 sw=2 ts=2
