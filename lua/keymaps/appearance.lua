-- ~/.config/nvims/kickstart/lua/keymaps/appearance.lua
-- [[ Appearance ]]
-- In normal- and visual-modes
--- Line numbers
vim.keymap.set({ 'n', 'x' }, '<Leader>ln', function()
  local default_value = true
  vim.o.relativenumber = vim.o.relativenumber == false and default_value or false
  print('relativenumber = ' .. tostring(vim.o.relativenumber) .. ', number = ' .. tostring(vim.o.number))
end, { desc = 'Toggle hybrid line numbers' })

--- Line wrapping
vim.keymap.set({ 'n', 'x' }, '<Leader>w', function()
  local default_value = true
  vim.o.wrap = vim.o.wrap == false and default_value or false
  print('wrap = ' .. tostring(vim.o.wrap))
end, { desc = 'Toggle line wrap' })

-- vim: et sts=2 sw=2 ts=2
