-- ~/.config/nvim/lua/custom/plugins/persistence.lua
-- Simple session management for Neovim
-- https://github.com/folke/persistence.nvim
return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 1,
    branch = true, -- use git branch to save session
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
