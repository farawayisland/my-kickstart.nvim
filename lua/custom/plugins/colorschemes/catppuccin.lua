-- ~/.config/nvims/kickstart/lua/custom/plugins/colorschemes/catppuccin.lua
-- Catppuccin
-- https://github.com/catppuccin/nvim
---@module 'lazy'
---@type LazySpec
return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'frappe', 'macchiato', or 'latte'.
    flavour = 'auto',
    background = { -- :h background
      dark = 'mocha',
      light = 'latte',
    },
    transparent_background = false, -- disables setting the background color.
    float = {
      transparent = false, -- enable transparent floating windows
      solid = false, -- use solid styling for floating windows, see |winborder|
    },
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = 'dark',
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { 'italic' }, -- Change the style of comments
      conditionals = { 'italic' },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
        ok = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
        ok = { 'underline' },
      },
      inlay_hints = {
        background = true,
      },
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    auto_integrations = false,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = '',
      },
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)

    -- Load the colorscheme here.
    vim.cmd.colorscheme 'catppuccin'
  end,
}

-- vim: et sts=2 sw=2 ts=2
