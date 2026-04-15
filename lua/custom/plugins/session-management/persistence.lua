-- ~/.config/nvims/kickstart/lua/custom/plugins/session-management/persistence.lua
-- Simple session management for Neovim
-- https://github.com/folke/persistence.nvim
return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  keys = {
    { mode = 'n', '<Leader>qs', function() require('persistence').load() end, desc = 'Load the session for the current directory' },
    { mode = 'n', '<Leader>qS', function() require('persistence').select() end, desc = 'Select a session to load' },
    { mode = 'n', '<Leader>ql', function() require('persistence').load { last = true } end, desc = 'Load the last session' },
    { mode = 'n', '<Leader>qd', function() require('persistence').stop() end, desc = "Stop Persistence => session won't be saved on exit" },
  },
  opts = {
    branch = true, -- use git branch to save session
    dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 1,
  },
  config = function(_, opts)
    require('persistence').setup(opts)
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('close-terminal-buffers', { clear = true }),
      pattern = 'PersistenceSavePre',
      desc = 'Close all terminal buffers, if any exists, before saving session',
      command = "bufdo if (bufname() =~ '^term://*') | bd! | endif",
    })
  end,
}

-- vim: et sts=2 sw=2 ts=2
