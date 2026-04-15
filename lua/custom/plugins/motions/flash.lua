-- ~/.config/nvims/kickstart/lua/custom/plugins/motions/flash.lua
--  Navigate your code with search labels, enhanced character motions and Treesitter integration
-- https://github.com/folke/flash.nvim
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = false,
      },
      search = {
        enabled = true,
      },
    },
  },
  keys = {
    -- In command-line mode
    { '<C-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    -- In normal, operator-pending, and visual modes
    { 's', mode = { 'n', 'o', 'x' }, function() require('flash').jump() end, desc = 'Flash' },
    { 'S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    -- In operator-pending mode
    { '<Leader>r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
    -- In operator-pending and visual modes
    { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
  },
}

-- vim: et sts=2 sw=2 ts=2
