-- ~/.config/nvims/kickstart/lua/kickstart/plugins/blink-cmp.lua
-- Performant, batteries-included completion plugin for Neovim
-- https://github.com/saghen/blink.cmp
---@module 'lazy'
---@type LazySpec
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    'folke/lazydev.nvim',
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
      },
      opts = {},
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <C-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <C-space>: Open menu or open docs if already open
      -- <C-n>/<C-p> or <up>/<down>: Select next/previous item
      -- <C-e>: Hide menu
      -- <C-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-e>'] = { 'hide' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-i>'] = { 'select_and_accept' },
      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },

      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- Show with a list of providers
      -- ['<C-Space>'] = {
      --   function(cmp)
      --     cmp.show { providers = { 'snippets' } }
      --   end,
      -- },

      ['<C-y>'] = { 'select_and_accept' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<C-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer',
      },
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        buffer = {
          -- Make buffer compeletions appear at the end.
          score_offset = -100,
          enabled = function()
            -- Filetypes for which buffer completions are enabled; add filetypes to extend:
            local enabled_filetypes = {
              'markdown',
              'text',
            }
            local filetype = vim.bo.filetype
            return vim.tbl_contains(enabled_filetypes, filetype)
          end,
        },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}

-- vim: et sts=2 sw=2 ts=2
