-- ~/.config/nvims/kickstart/lua/keymaps/buffer-management.lua
-- [[ Buffer management ]]
-- In normal mode
--- Buffer deletion
vim.keymap.set('n', '<Leader>bd', '<Cmd>bd<CR>', { desc = 'Delete current buffer' })

vim.keymap.set(
  'n',
  '<Leader>bd.',
  ":<C-u>ibufdo if (bufname() =~ '\\.$') <Bar> bd <Bar> endifF.a",
  { desc = 'Delete all buffers with a given filename extension' }
)

vim.keymap.set('n', '<Leader>bdh', '<Cmd>bp <Bar> sp <Bar> bn <Bar> bd<CR>', { desc = 'then open previous buffer and keep current horizontally split window' })

vim.keymap.set(
  'n',
  '<Leader>bdnt',
  "<Cmd>bufdo if (bufname() =~ '^\\(term://*\\)\\@!.') <Bar> bd <Bar> endif<CR>",
  { desc = 'Delete all non-terminal buffers' }
)

vim.keymap.set('n', '<Leader>bdv', '<Cmd>bp <Bar> vsp <Bar> bn <Bar> bd<CR>', { desc = 'then open previous buffer and keep current vertically split window' })

vim.keymap.set('n', '<Leader>bk', '<Cmd>bd!<CR>', { desc = 'Force delete current buffer' })

vim.keymap.set(
  'n',
  '<Leader>bk.',
  ":<C-u>ibufdo if (bufname() =~ '\\.$') <Bar> bd! <Bar> endifF.a",
  { desc = 'Force delete all buffers with a given filename extension' }
)

vim.keymap.set('n', '<Leader>bkh', '<Cmd>bp <Bar> sp <Bar> bn <Bar> bd!<CR>', { desc = 'then open previous buffer and keep current horizontally split window' })

vim.keymap.set(
  'n',
  '<Leader>bknt',
  "<Cmd>bufdo if (bufname() =~ '^\\(term://*\\)\\@!.') <Bar> bd! <Bar> endif<CR>",
  { desc = 'Force delete all non-terminal buffers' }
)

vim.keymap.set('n', '<Leader>bkv', '<Cmd>bp <Bar> vsp <Bar> bn <Bar> bd!<CR>', { desc = 'then open previous buffer and keep current vertically split window' })

-- vim: et sts=2 sw=2 ts=2
