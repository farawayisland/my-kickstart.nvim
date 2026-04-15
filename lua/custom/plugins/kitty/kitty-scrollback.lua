-- ~/.config/nvims/kickstart/lua/custom/plugins/kitty/kitty-scrollback.lua
-- Open your Kitty scrollback buffer with Neovim
-- https://github.com/mikesmithgh/kitty-scrollback.nvim
return {
  'mikesmithgh/kitty-scrollback.nvim',
  enabled = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
  event = { 'User KittyScrollbackLaunch' },
  lazy = true,
  opts = {},
  -- version = '*', -- latest stable version, may have breaking changes if major version changed
  -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
}

-- vim: et sts=2 sw=2 ts=2
