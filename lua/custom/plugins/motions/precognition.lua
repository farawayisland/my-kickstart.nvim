-- ~/.config/nvims/kickstart/lua/custom/plugins/motions/precognition.lua
-- Uses virtual text and gutter signs to show available motions
-- https://github.com/tris203/precognition.nvim
return {
  'tris203/precognition.nvim',
  --event = "VeryLazy",
  opts = {
    -- disabled_fts = {
    --     "startify",
    -- },
    -- gutterHints = {
    --     G = { text = "G", prio = 10 },
    --     gg = { text = "gg", prio = 9 },
    --     PrevParagraph = { text = "{", prio = 8 },
    --     NextParagraph = { text = "}", prio = 8 },
    -- },
    -- highlightColor = { link = "Comment" },
    -- hints = {
    --      Caret = { text = "^", prio = 2 },
    --      Dollar = { text = "$", prio = 1 },
    --      MatchingPair = { text = "%", prio = 5 },
    --      Zero = { text = "0", prio = 1 },
    --      w = { text = "w", prio = 10 },
    --      b = { text = "b", prio = 9 },
    --      e = { text = "e", prio = 8 },
    --      W = { text = "W", prio = 7 },
    --      B = { text = "B", prio = 6 },
    --      E = { text = "E", prio = 5 },
    -- },
    -- showBlankVirtLine = true,
    -- startVisible = true,
  },
  config = function(_, opts)
    require('precognition').setup(opts)
    -- Keymaps
    --- In normal and visual modes
    --- -- Toggle
    vim.keymap.set({ 'n', 'x' }, '<Leader>ptp', function() require('precognition').toggle() end, { desc = 'Toggle precognition.nvim' })
  end,
}

-- vim: et sts=2 sw=2 ts=2
