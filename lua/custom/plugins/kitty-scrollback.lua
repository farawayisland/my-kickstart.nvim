-- ~/.config/nvim/lua/custom/plugins/kitty-scrollback.lua
-- Open your Kitty scrollback buffer with Neovim
-- https://github.com/mikesmithgh/kitty-scrollback.nvim
return {
  'mikesmithgh/kitty-scrollback.nvim',
  enabled = true,
  lazy = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
  event = { 'User KittyScrollbackLaunch' },
  -- version = '*', -- latest stable version, may have breaking changes if major version changed
  -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
  opts = {},
}
