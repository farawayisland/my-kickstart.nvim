-- ~/.config/nvims/kickstart/lua/keymaps/navigation.lua
-- [[ Navigation ]]
-- In command-line-, insert-, and terminal-modes
vim.keymap.set({ 'c', 'i', 't' }, '<M-h>', '<Left>', { desc = 'Move leftward' })
vim.keymap.set({ 'c', 'i', 't' }, '<M-l>', '<Right>', { desc = 'Move rightward' })
vim.keymap.set({ 'c', 'i', 't' }, '˙', '<Left>', { desc = 'Move leftward (macOS: Option-h)' })
vim.keymap.set({ 'c', 'i', 't' }, '¬', '<Right>', { desc = 'Move rightward (macOS: Option-l)' })

-- In command-line- and insert-modes
vim.keymap.set({ 'c', 'i' }, '<M-Left>', '<S-Left>', { desc = 'Move one word backward' })
vim.keymap.set({ 'c', 'i' }, '<M-Right>', '<S-Right>', { desc = 'Move one word forward' })
vim.keymap.set({ 'c', 'i' }, '<M-S-h>', '<S-Left>', { desc = 'Move one word backward' })
vim.keymap.set({ 'c', 'i' }, '<M-S-l>', '<S-Right>', { desc = 'Move one word forward' })
vim.keymap.set({ 'c', 'i' }, 'Ó', '<S-Left>', { desc = 'Move one word backward (macOS: Option-Shift-h)' })
vim.keymap.set({ 'c', 'i' }, 'Ò', '<S-Right>', { desc = 'Move one word forward (macOS: Option-Shift-l)' })

-- In command-line- and terminal-modes
vim.keymap.set({ 'c', 't' }, '<M-j>', '<C-n>', { desc = 'Recall more recent command-line from history' })
vim.keymap.set({ 'c', 't' }, '<M-k>', '<C-p>', { desc = 'Recall older command-line from history' })
vim.keymap.set({ 'c', 't' }, '∆', '<C-n>', { desc = 'Recall more recent command-line from history (macOS: Option-j)' })
vim.keymap.set({ 'c', 't' }, '˚', '<C-p>', { desc = 'Recall older command-line from history (macOS: Option-k)' })

-- In command-line mode
--- Mode navigation
vim.keymap.set('c', 'kj', '<C-c>', { desc = 'Exit command-line mode' })

-- In insert mode
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', '<M-j>', '<Down>', { desc = 'Move downward' })
vim.keymap.set('i', '<M-k>', '<Up>', { desc = 'Move upward' })
vim.keymap.set('i', '∆', '<Down>', { desc = 'Move downward (macOS: Option-j)' })
vim.keymap.set('i', '˚', '<Up>', { desc = 'Move upward (macOS: Option-k)' })

-- In normal- and visual-modes
--- Buffer navigation
vim.keymap.set({ 'n', 'x' }, '<Leader>n', '<Cmd>bn<CR>', { desc = 'Go to next buffer' })
vim.keymap.set({ 'n', 'x' }, '<Leader>pb', '<Cmd>bp<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set({ 'n', 'x' }, '<Tab><Leader>', '<Cmd>b ^\\(term://*\\)<CR>', { desc = 'Switch to terminal buffer' })

--- Character navigation
vim.keymap.set({ 'n', 'x' }, '<Leader>h', '^', { desc = 'Go to first non-blank character of current line' })

vim.keymap.set({ 'n', 'x' }, '<Leader>l', 'g_', { desc = 'Go to last non-blank character of current line and [count - 1] lines downward' })

--- Cursor jumping
vim.keymap.set({ 'n', 'x' }, '``', '``zz', { desc = 'Go to previous jump/mark and redraw line at center of window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>m', '<Cmd>marks<CR>:norm! `', { desc = 'List all marks and prompt return to unspecified mark' })

--- Mode navigation
vim.keymap.set({ 'n', 'x' }, 'vv', '<C-v>', { desc = 'Enter visual mode blockwise' })

--- Regex pattern-based navigation
vim.keymap.set({ 'n', 'x' }, '<Leader>cl', '/i\\v(^[^#]*#+\\s+)@<=\\S.*:s;#;;g<Left><Left>', { desc = 'Search for commented lines' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ul', '/i\\v(^\\s*)@<=[^[:blank:]#][^#]*($|\\s+#)@=:s;#;;g<Left><Left>', { desc = 'Search for uncommented lines' })
vim.keymap.set({ 'n', 'x' }, 'N', 'Nzz', { desc = 'Repeat the latest "/" or "?" [count] times in opposite direction and redraw line at center of window' })

vim.keymap.set({ 'n', 'x' }, 'n', 'nzz', { desc = 'Repeat the latest "/" or "?" [count] times and redraw line at center of window' })

--- Scrolling
vim.keymap.set({ 'n', 'x' }, '<C-d>', function()
  vim.o.scroll = vim.v.count1 == 1 and vim.o.scroll or vim.v.count1
  return '<Cmd>exe "norm!' .. vim.o.scroll .. 'j"<CR>zz'
end, { desc = "Scroll window 'scroll' amount downward (ignoring wrapped lines) and redraw line at center of window", expr = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<C-n>', '<C-n>zz', { desc = 'Go to [count] lines downward and redraw line at center of window' })
vim.keymap.set({ 'n', 'x' }, '<C-p>', '<C-p>zz', { desc = 'Go to [count] lines upward and redraw line at center of window' })

vim.keymap.set({ 'n', 'x' }, '<C-u>', function()
  vim.o.scroll = vim.v.count1 == 1 and vim.o.scroll or vim.v.count1
  return '<Cmd>exe "norm!' .. vim.o.scroll .. 'k"<CR>zz'
end, { desc = "Scroll window 'scroll' amount upward (ignoring wrapped lines) and redraw line at center of window", expr = true, silent = true })

vim.keymap.set({ 'n', 'x' }, '<Leader>s', function()
  local default_value = 5
  vim.o.scroll = vim.o.scroll == math.floor(vim.api.nvim_win_get_height(0) / 2) and default_value or 0
  print('scroll = ' .. vim.o.scroll .. ', height = ' .. vim.api.nvim_win_get_height(0))
end, { desc = "Cycle 'scroll' between 0 (half of window height) and 5 (my default)" })

vim.keymap.set({ 'n', 'x' }, '<Leader>so', function()
  local default_value = 3
  vim.o.scrolloff = vim.o.scrolloff == 0 and default_value or 0
  print('scrolloff = ' .. vim.o.scrolloff .. ', height = ' .. vim.api.nvim_win_get_height(0))
end, { desc = "Cycle 'scrolloff' between 0 and 3 (my default)" })

--- Tab-switching
vim.keymap.set({ 'n', 'x' }, '<Leader>1', '1gt', { desc = 'Go to 1st tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>2', '2gt', { desc = 'Go to 2nd tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>3', '3gt', { desc = 'Go to 3rd tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>4', '4gt', { desc = 'Go to 4th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>5', '5gt', { desc = 'Go to 5th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>6', '6gt', { desc = 'Go to 6th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>7', '7gt', { desc = 'Go to 7th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>8', '8gt', { desc = 'Go to 8th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>9', '9gt', { desc = 'Go to 9th tab' })

-- In normal mode
--- Buffer navigation
vim.keymap.set('n', '<Leader><Tab>', '<C-^>', { desc = 'Switch between current and last buffer' })

-- In terminal mode
--- Mode navigation
vim.keymap.set('t', 'kj', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- In visual mode
--- Buffer navigation
vim.keymap.set('x', '<Leader><Tab>', ':<C-u>exe "norm! \\<lt>C-^>"<CR>', { desc = 'Switch between current and last buffer', silent = true })

--- Mode navigation
vim.keymap.set('x', 'kj', '<Esc>', { desc = 'Exit visual mode' })

-- vim: et sts=2 sw=2 ts=2
