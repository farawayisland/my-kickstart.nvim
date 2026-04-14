-- ~/.config/nvims/kickstart/lua/kickstart/plugins/treesitter.lua
-- Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter
-- Show code context
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- Syntax aware text-objects, select, move, swap, and peek support
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
---@module 'lazy'
---@type LazySpec
return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    commit = 'ebc3201', -- Temporarily pins to parent commit of
    -- https://github.com/nvim-treesitter/nvim-treesitter/commit/b9f9d692f1c7f0427502a3b84fa25d4bedb29ec1,
    -- which includes breaking changes for
    -- https://github.com/georgeharker/tree-sitter-zsh
    build = ':TSUpdate',
    lazy = false,
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    opts = {
      ensure_installed = {
        'ada',
        'agda',
        'asm',
        'awk',
        'bash',
        'c',
        'cmake',
        'commonlisp',
        'cpp',
        'css',
        'csv',
        'diff',
        'editorconfig',
        'fish',
        'fortran',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'glsl',
        'go',
        'haskell',
        'html',
        'java',
        'javadoc',
        'javascript',
        'json',
        'kotlin',
        'llvm',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'nix',
        'perl',
        'php',
        'php_only',
        'phpdoc',
        'powershell',
        'python',
        'query',
        'r',
        'ruby',
        'rust',
        'swift',
        'toml',
        'typescript',
        'typst',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
        'zig',
        'zsh',
      },
    },
    config = function(_, opts)
      -- install parsers
      if opts.ensure_installed and #opts.ensure_installed > 0 then require('nvim-treesitter').install(opts.ensure_installed) end

      -- Zsh-specific configuration
      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'
          if vim.tbl_contains(installed_parsers, 'zsh') then
            require('nvim-treesitter.parsers').zsh = {
              install_info = {
                'https://github.com/georgeharker/tree-sitter-zsh',
                generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
                queries = 'nvim-queries', -- also install queries from given directory
              },
              tier = 3,
            }
          end
        end,
      })

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then return end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- enables treesitter based folds
        -- for more info on folds see `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, 'indent') ~= nil

        -- enables treesitter based indentation
        if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language or language == 'latex' then return end

          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            -- enable the parser if it is installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
            require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
          else
            -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      event = 'BufRead',
    },
    event = 'BufRead',
    ---@module 'nvim-treesitter-context'
    opts = {
      multiwindow = true,
    },
    keys = {
      { mode = { 'n', 'x' }, '<Leader>cn', '<Cmd>TSContext toggle<CR>', desc = 'Toggle code context' },
      { mode = { 'n', 'x' }, '[c', function() require('treesitter-context').go_to_context(vim.v.count1) end, desc = 'Jump to context', silent = true },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    ---@module 'nvim-treesitter-textobjects'
    opts = { multiwindow = true },
    keys = {
      {
        'ac',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
        desc = 'Select outer class',
        mode = { 'o', 'x' },
      },
      {
        'af',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end,
        desc = 'Select outer function',
        mode = { 'o', 'x' },
      },
      {
        'as',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals') end,
        desc = 'Select local scope',
        mode = { 'o', 'x' },
      },
      {
        'ic',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
        desc = 'Select inner class',
        mode = { 'o', 'x' },
      },
      {
        'if',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end,
        desc = 'Select inner function',
        mode = { 'o', 'x' },
      },
    },
  },
}

-- vim: et sts=2 sw=2 ts=2
