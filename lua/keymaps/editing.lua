-- ~/.config/nvims/kickstart/lua/keymaps/editing.lua
-- [[ Editing ]]
-- In command-line mode
--- Copying (yanking) and pasting (putting)
vim.keymap.set('c', '<Leader>P', '<C-r>0', { desc = 'Insert last yanked text' })
vim.keymap.set('c', '<Leader>PP', '<C-r>+', { desc = 'Insert system clipboard contents' })

-- In normal- and visual-modes
--- Command-line window
vim.keymap.set({ 'n', 'x' }, '<Leader>;', 'q:', { desc = 'Open command-line window' })

--- Copying (yanking) and pasting (putting)
vim.keymap.set({ 'n', 'x' }, '<Leader>yap', '<Cmd>let @+=expand("%:p")<CR>', { desc = 'Yank absolute path of current file' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ydn', '<Cmd>let @+=expand("%:p:h")<CR>', { desc = 'Yank directory name of current file' })
vim.keymap.set({ 'n', 'x' }, '<Leader>yfn', '<Cmd>let @+=expand("%:t")<CR>', { desc = 'Yank filename of current file' })
vim.keymap.set({ 'n', 'x' }, '<Leader>yrp', '<Cmd>let @+=expand("%")<CR>', { desc = 'Yank relative path of current file' })

--- Edit characters
vim.keymap.set({ 'n', 'x' }, '<S-Enter>', 'r<CR>', { desc = 'Replace the character under the cursor with <CR>' })
-- vim.keymap.set({ 'n', 'x' }, 's', 'xi', { desc = 'Delete characters under and after the cursor then enter insert mode' })

--- Edit existing files and buffers
vim.keymap.set({ 'n', 'x' }, '<Leader>il', '<Cmd>e $MYVIMRC<CR>', { desc = 'Edit ' .. os.getenv 'MYVIMRC' })
vim.keymap.set({ 'n', 'x' }, '<Leader>sp', '<Cmd>sp<CR>', { desc = 'Edit current buffer in new horizontally split window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ts', '<Cmd>tab sp<CR>', { desc = 'Edit current buffer in new tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>vs', '<Cmd>vs<CR>', { desc = 'Edit current buffer in new vertically split window' })

--- Edit new file
--- -- Empty files
vim.keymap.set({ 'n', 'x' }, '<Leader>e', ':<C-u>e ', { desc = 'Edit in current window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>en', '<Cmd>ene<CR>', { desc = 'a new, unnamed buffer' })
vim.keymap.set({ 'n', 'x' }, '<Leader>te', '<Cmd>tabe<CR>', { desc = 'Edit in new tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wh', '<Cmd>new<CR>', { desc = 'Edit in new horizontally split window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wv', '<Cmd>vne<CR>', { desc = 'Edit in new vertically split window' })

--- -- Redirected output
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>map',
  '<Cmd>redir @a<Bar>silent map<Bar>redir END<Bar>new<Bar>put a<CR>',
  { desc = "Edit output of ':map' in new horizontally split window" }
)

--- -- Templates
--- --- Neovim plugin file
vim.keymap.set({ 'n', 'x' }, '<Leader>etnvp', function()
  local config_path = vim.fn.stdpath 'config'
  local change_dir_into_config_path = '<Cmd>cd ' .. config_path .. '<CR>'
  local edit_new_file = '<Cmd>ene<CR>'

  local insert_plugin_template = '<Cmd>%!echo '
    .. '"-- ~/.config/nvim/lua/custom/plugins/.lua\\n'
    .. '--\\n'
    .. '-- https://github.com/username/repository\\nreturn {\\n'
    .. "  'username/repository',\\n"
    .. '  opts = {},\\n'
    .. '  config = function(_, opts)\\n'
    .. "    require('plugin').setup(opts)\\n"
    .. '  end,\\n'
    .. '}"<CR>'

  local write_file = ':<C-u>iw ' .. 'lua/custom/plugins/' .. '.luaF.i'

  return change_dir_into_config_path .. edit_new_file .. insert_plugin_template .. write_file
end, { desc = 'a Neovim plugin-configuration file-template', expr = true, silent = true })

--- Regex pattern-based editing
vim.keymap.set('n', '<Leader>erf+0', '<Cmd>let @+=@0<CR>', { desc = 'Fill register `+` with contents of register `0`' })
vim.keymap.set('n', '<Leader>erf0+', '<Cmd>let @0=@+<CR>', { desc = 'Fill register `0` with contents of register `+`' })
vim.keymap.set('n', '<Leader>erfab', ':<C-u>ilet @a=@bFa', { desc = 'Fill register `a` with contents of register `b`' })

vim.keymap.set(
  'n',
  '<Leader>ern',
  ":<C-u>ilet @a=substitute(strtrans(@a), '\\^@', ' ', 'g'):s;@a;@;g<Left><Left>",
  { desc = 'Replace newlines in register `a` with spaces' }
)

vim.keymap.set('n', '<Leader>ern+', "<Cmd>let @+=substitute(strtrans(@+), '\\^@', ' ', 'g')<CR>", { desc = 'Replace newlines in register `+` with spaces' })

vim.keymap.set('n', '<Leader>ern0', "<Cmd>let @0=substitute(strtrans(@0), '\\^@', ' ', 'g')<CR>", { desc = 'Replace newlines in register `0` with spaces' })

vim.keymap.set({ 'n', 'x' }, '<Leader>er\\', '<Cmd>s;\\\\;\\\\\\\\;g<CR>', { desc = 'Replace backslashes with escaped ones' })
vim.keymap.set({ 'n', 'x' }, '<Leader>erfn', ':<C-u>1,5s;\\v(.*/)(\\.)@=;\\1', { desc = 'Replace filename part of file path comment' })

vim.keymap.set(
  { 'n', 'x' },
  '<Leader>ernvpcwo',
  ':<C-u>%s;\\vconfig \\= function\\(\\)\\_.{-}require\\(.{-}\\)\\.setup\\((\\{\\_.{-}\\})\\)\\_.{-}end(,)?;opts = \\1\\2',
  { desc = "Replace 'config = function() require(<plugin>).setup({})' with 'opts = {}'" }
)

vim.keymap.set(
  { 'n', 'x' },
  '<Leader>ernvpit',
  ':<C-u>4,$s;\\v(\\{\\_.)@<=\\_.*(\\})@=;\\=@+',
  { desc = 'Replace inside of table with clipboard contents in Neovim plugin-configuration file-template' }
)

vim.keymap.set({ 'n', 'x' }, '<Leader>ernvprl', function()
  local put_user_and_repo_name = '<Cmd>3,4s;\\v(github\\.com/)@<=.{-}($\\_.{-}(\'|")(.{-})(\'|"))@=;\\=@a<CR>'
  local yank_user_and_repo_name = "<Cmd>5s;\\v('|\")@<=.{-}('|\")@=;\\=setreg('a', submatch(0));n<CR>"
  return yank_user_and_repo_name .. put_user_and_repo_name
end, { desc = 'Replace repository link comment in Neovim plugin-configuration file-template', expr = true, silent = true })

-- In normal mode
--- Line commenting
vim.keymap.set('n', '<Leader>j', function()
  local recenter = vim.v.count1 == 1 and 'zz' or (vim.v.count1 - 1) .. 'jzz'
  return '<Cmd>exe "norm' .. vim.v.count1 .. 'gcc"<CR>' .. recenter
end, { desc = 'Comment or uncomment [count] lines starting at cursor and redraw line at center of window', expr = true, silent = true })

vim.keymap.set('n', '<Leader>k', function()
  local current_line_or_motion = vim.v.count1 == 1 and 'c' or (vim.v.count1 - 1) .. 'k'
  return '<Cmd>exe "norm gc' .. current_line_or_motion .. '"<CR>zz'
end, { desc = 'Comment or uncomment [count] lines backward starting at cursor and redraw line at center of window', expr = true, silent = true })

--- Line indentation
vim.keymap.set('n', '<Leader>[', '<<', { desc = "Shift [count] lines one 'shiftwidth' leftward" })
vim.keymap.set('n', '<Leader>]', '>>', { desc = "Shift [count] lines one 'shiftwidth' rightward" })

-- In visual mode
--- Copying (yanking) and pasting (putting)
vim.keymap.set('x', 'P', 'p', { desc = 'Put without changing unnamed register in visual mode' })
vim.keymap.set('x', 'p', 'P', { desc = 'Put and change unnamed register with selection in visual mode' })

vim.keymap.set('x', 'Y', 'mlY`lzz', { desc = 'Yank the highlighted lines, return to last cursor position, and redraw line at center of window' })

vim.keymap.set('x', 'y', 'mly`lzz', { desc = 'Yank the highlighted text, return to last cursor position, and redraw line at center of window' })

--- Line commenting
vim.keymap.set(
  'x',
  '<Leader>j',
  'ml<Cmd>exe "norm gc"<CR>`lzz',
  { desc = 'Comment or uncomment the selected line(s), return to last cursor position, and redraw line at center of window' }
)

vim.keymap.set(
  'x',
  '<Leader>k',
  'ml<Cmd>exe "norm gc"<CR>`lzz',
  { desc = 'Comment or uncomment the selected line(s), return to last cursor position, and redraw line at center of window' }
)

--- Line indentation
vim.keymap.set('x', '<Leader>[', '<', { desc = "Shift the highlighted lines [count] 'shiftwidth' leftward" })
vim.keymap.set('x', '<Leader>]', '>', { desc = "Shift the highlighted lines [count] 'shiftwidth' rightward" })

-- vim: et sts=2 sw=2 ts=2
