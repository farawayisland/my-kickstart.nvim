-- ~/.config/nvims/kickstart/lua/gui/neovide.lua
-- [[ Neovide-specific configurations ]]
if vim.g.neovide then
  -- Animation trail size
  --  Source: https://neovide.dev/configuration.html#animation-trail-size
  vim.g.neovide_cursor_trail_size = 1.0
  -- Fullscreen
  --  Source: https://neovide.dev/configuration.html#fullscreen
  vim.g.neovide_fullscreen = true
  -- GUI cursor options
  --  Source: https://neovim.io/doc/user/options.html#'guicursor'
  vim.opt.guicursor = {
    'n-c-o-sm-v-ve:block',
    'ci-i-t:ver25',
    'r-cr:hor20',
  }
end

-- vim: et sts=2 sw=2 ts=2
