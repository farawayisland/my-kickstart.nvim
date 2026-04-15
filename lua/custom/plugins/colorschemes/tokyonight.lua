-- ~/.config/nvims/kickstart/lua/custom/plugins/colorschemes/tokyonight.lua
-- Tokyo Night
-- https://github.com/folke/tokyonight.nvim
---@module 'lazy'
---@type LazySpec
return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'storm', 'moon', or 'day'.
    style = 'night',
    light_style = 'day',
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)

    -- Load the colorscheme here.
    vim.cmd.colorscheme 'tokyonight'
  end,
}

-- vim: et sts=2 sw=2 ts=2
