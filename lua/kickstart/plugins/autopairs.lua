-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'
    local cond = require 'nvim-autopairs.conds'
    local Rule = require 'nvim-autopairs.rule'
    npairs.setup(opts)
    npairs.add_rule(Rule('$', '$', { 'org', 'tex', 'latex' }):with_move(cond.done()))
    npairs.add_rule(Rule('\\(', '\\)', { 'org', 'tex', 'latex' }))
    npairs.add_rule(Rule('\\[', '\\]', { 'org', 'tex', 'latex' }))
  end,
}
