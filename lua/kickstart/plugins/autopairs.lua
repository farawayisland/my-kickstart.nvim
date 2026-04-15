-- ~/.config/nvims/kickstart/lua/kickstart/plugins/autopairs.lua
-- autopairs
-- https://github.com/windwp/nvim-autopairs

---@module 'lazy'
---@type LazySpec
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)
    local npairs = require 'nvim-autopairs'
    local cond = require 'nvim-autopairs.conds'
    local Rule = require 'nvim-autopairs.rule'
    npairs.setup(opts)
    npairs.add_rule(Rule('$', '$', { 'org', 'tex', 'latex' }):with_move(cond.done()))
    npairs.add_rule(Rule('/', '/', { 'org' }):with_move(cond.done()))
    npairs.add_rule(Rule('=', '=', { 'org' }):with_move(cond.done()))
    npairs.add_rule(Rule('\\(', '\\)', { 'org', 'tex', 'latex' }))
    npairs.add_rule(Rule('\\[', '\\]', { 'org', 'tex', 'latex' }))
    npairs.add_rule(Rule('~', '~', { 'org' }):with_move(cond.done()))
  end,
}

-- vim: et sts=2 sw=2 ts=2
