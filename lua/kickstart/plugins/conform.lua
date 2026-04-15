-- ~/.config/nvims/kickstart/lua/kickstart/plugins/conform.lua
-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim
---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<Leader>fb',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = '[F]ormat [B]uffer',
    },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = {}
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      bash = {
        'shfmt', -- https://github.com/mvdan/sh
        'shellharden', -- https://github.com/anordal/shellharden
      },
      c = { 'clang-format' }, -- https://clang.llvm.org/docs/ClangFormat.html
      cpp = { 'clang-format' },
      -- haskell = { 'stylish-haskell' }, -- https://github.com/haskell/stylish-haskell
      java = { 'google-java-format' }, -- https://github.com/google/google-java-format
      javascript = {
        'prettierd', -- https://github.com/fsouza/prettierd
        'prettier', -- https://github.com/prettier/prettier
        stop_after_first = true,
      },
      lua = { 'stylua' }, -- https://github.com/JohnnyMorganz/StyLua
      markdown = { 'markdownlint', 'injected' }, -- https://github.com/davidanson/markdownlint
      -- perl = { 'perltidy' }, -- https://perltidy.github.io/perltidy
      python = {
        -- https://github.com/astral-sh/ruff
        -- To fix auto-fixable lint errors
        'ruff_fix',
        -- To run the Ruff formatter
        'ruff_format',
        -- To organize the imports
        'ruff_organize_imports',
      },
      -- r = { 'air' }, -- https://posit-dev.github.io/air
      -- ruby = { 'rubyfmt' }, -- https://github.com/fables-tales/rubyfmt
      rust = { 'rustfmt' }, -- https://rust-lang.github.io/rustfmt
      tex = { 'tex-fmt' }, -- https://github.com/WGUNDERWOOD/tex-fmt
      typescript = {
        'prettierd',
        'prettier',
        stop_after_first = true,
      },
      typst = { 'typstyle' }, -- https://typstyle-rs.github.io/typstyle
    },
  },
  config = function(_, opts)
    -- Source: https://github.com/astral-sh/ruff/issues/12778#issuecomment-2290450339
    require('conform').setup(opts)
    require('conform').formatters.ruff_format = {
      append_args = {
        '--line-length',
        '80',
      },
    }
  end,
}

-- vim: et sts=2 sw=2 ts=2
