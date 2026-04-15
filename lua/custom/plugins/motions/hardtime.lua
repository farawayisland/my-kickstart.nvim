-- ~/.config/nvims/kickstart/lua/custom/plugins/motions/hardtime.lua
-- Break bad habits, master Vim motions
-- https://github.com/m4xshen/hardtime.nvim
return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  lazy = false,
  keys = {
    -- In normal and visual modes
    { '<Leader>pth', mode = { 'n', 'x' }, function() require('hardtime').toggle() end, desc = 'Toggle hardtime.nvim' },
  },
  opts = {},
}

-- vim: et sts=2 sw=2 ts=2
