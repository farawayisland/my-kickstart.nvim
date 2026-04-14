-- ~/.config/nvims/kickstart/lua/autocommands/basic.lua
-- [[ Basic autocommands ]]
--  See `:help lua-guide-autocommands`

-- Auto-create missing dirs when saving a file
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Auto-create missing dirs when saving a file',
  group = vim.api.nvim_create_augroup('kickstart-auto-create-dir', { clear = true }),
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand '<afile>:p:h'
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, 'p') end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank { timeout = 200 } end,
})

-- Restore cursor position on file open
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor position on file open',
  group = vim.api.nvim_create_augroup('kickstart-restore-cursor', { clear = true }),
  pattern = '*',
  callback = function()
    local line = vim.fn.line '\'"'
    if line > 1 and line <= vim.fn.line '$' then vim.cmd 'normal! g\'"' end
  end,
})

-- Autosave and autoload folds
--  Source: https://stackoverflow.com/a/77180744
vim.api.nvim_create_autocmd('BufWinLeave', {
  desc = 'Save view (folds), when closing file',
  group = vim.api.nvim_create_augroup('save-folds', { clear = true }),
  pattern = { '*.*' },
  command = 'mkview',
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Load view (folds), when opening file',
  group = vim.api.nvim_create_augroup('load-folds', { clear = true }),
  pattern = { '*.*' },
  command = 'silent! loadview',
})

-- Start insert mode when initializing a terminal buffer
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Start insert mode when initializing a terminal buffer',
  group = vim.api.nvim_create_augroup('startinsert-initialized-terminal-buffer', { clear = true }),
  command = 'startinsert',
})

-- vim: et sts=2 sw=2 ts=2
