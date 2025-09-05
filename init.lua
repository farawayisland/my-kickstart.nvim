--[[ Kickstart.nvim
~/.config/nvim/init.lua
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Set clipboard (pbcopy and pbpaste by default on macOS)
-- vim.g.clipboard = {
--   name = 'xsel',
--   copy = {
--     ['+'] = 'xsel --nodetach -ib',
--     ['*'] = 'xsel --nodetach -ip',
--   },
--   paste = {
--     ['+'] = 'xsel -ob',
--     ['*'] = 'xsel -op',
--   },
--   cache_enabled = true,
-- }

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Number of lines to scroll with CTRL-U and CTRL-D commands
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('set-scroll-value', { clear = true }),
  pattern = { '*.*' },
  desc = "Set 'scroll' value to 5 instead of half of window height",
  callback = function()
    vim.o.scroll = 5
  end,
})

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 3

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<Leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uick[f]ix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal and visual modes
vim.keymap.set({ 'n', 'x' }, '<Down>', '<Cmd>echo "Use j to move!"<CR>')
vim.keymap.set({ 'n', 'x' }, '<Left>', '<Cmd>echo "Use h to move!"<CR>')
vim.keymap.set({ 'n', 'x' }, '<Right>', '<Cmd>echo "Use l to move!"<CR>')
vim.keymap.set({ 'n', 'x' }, '<Up>', '<Cmd>echo "Use k to move!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set({ 'n', 'x' }, '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 'x' }, '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 'x' }, '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({ 'n', 'x' }, '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<Leader>s', group = '[S]earch' },
        { '<Leader>t', group = '[T]oggle' },
        { '<Leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = {
              -- ['<C-Enter>'] = 'to_fuzzy_refine',
              ['<C-BS>'] = function()
                vim.cmd 'exe "norm! i\\<C-u>"'
              end,
              ['<Leader>P'] = function()
                vim.cmd 'exe "norm! i\\<C-r>0"'
              end,
              ['<Leader>PP'] = function()
                vim.cmd 'exe "norm! i\\<C-r>+"'
              end,
            },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<Leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<Leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<Leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<Leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<Leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<Leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<Leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<Leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<Leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<Leader><Leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<Leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<Leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<Leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<Leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        basedpyright = {},
        clangd = {},
        --
        -- gopls = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        texlab = {},
        --
        -- Some languages (like TypeScript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        --
        ts_ls = {},

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'black', -- Python code formatter | https://github.com/psf/black
        'clang-format', -- C code formatter | https://clang.llvm.org/docs/ClangFormat.html
        'isort', -- Python imports sorter | https://github.com/PyCQA/isort
        'prettier', -- Multilingual code formatter | https://github.com/prettier/prettier
        'prettierd', -- Multilingual code formatter | https://github.com/fsouza/prettierd
        'stylua', -- Lua code formatter | https://github.com/JohnnyMorganz/StyLua
        'tex-fmt', -- LaTeX code formatter | https://github.com/WGUNDERWOOD/tex-fmt
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<Leader>fb',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat [b]uffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
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
        lua = { 'stylua' }, -- https://github.com/JohnnyMorganz/StyLua
        tex = { 'tex-fmt' }, -- https://github.com/WGUNDERWOOD/tex-fmt
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
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
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
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
        -- show with a list of providers
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
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
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
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('catppuccin').setup {
        flavour = 'auto', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = false, -- disables setting the background color.
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
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }

      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'commonlisp',
        'diff',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'typescript',
        'vim',
        'vimdoc',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex' },
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- [[ Additional Keymaps ]]
-- Sources:
-- https://stackoverflow.com/a/6228454
-- https://stackoverflow.com/a/13831705
-- https://stackoverflow.com/a/77072373
-- https://superuser.com/a/410851
-- https://superuser.com/a/963068
-- https://vi.stackexchange.com/a/6737
-- https://vi.stackexchange.com/a/8453
-- https://vi.stackexchange.com/a/18081

-- Command, Insert, and Terminal modes
vim.keymap.set({ 'c', 'i', 't' }, '<M-h>', '<Left>', { desc = 'Move leftward' })
vim.keymap.set({ 'c', 'i', 't' }, '<M-l>', '<Right>', { desc = 'Move rightward' })
vim.keymap.set({ 'c', 'i', 't' }, '˙', '<Left>', { desc = 'Move leftward (macOS: Option-h)' })
vim.keymap.set({ 'c', 'i', 't' }, '¬', '<Right>', { desc = 'Move rightward (macOS: Option-l)' })

-- Command and Insert modes
vim.keymap.set({ 'c', 'i' }, '<M-Left>', '<S-Left>', { desc = 'Move one word backward' })
vim.keymap.set({ 'c', 'i' }, '<M-Right>', '<S-Right>', { desc = 'Move one word forward' })
vim.keymap.set({ 'c', 'i' }, '<M-S-h>', '<S-Left>', { desc = 'Move one word backward' })
vim.keymap.set({ 'c', 'i' }, '<M-S-l>', '<S-Right>', { desc = 'Move one word forward' })
vim.keymap.set({ 'c', 'i' }, 'Ó', '<S-Left>', { desc = 'Move one word backward (macOS: Option-Shift-h)' })
vim.keymap.set({ 'c', 'i' }, 'Ò', '<S-Right>', { desc = 'Move one word forward (macOS: Option-Shift-l)' })

-- Command and Terminal modes
vim.keymap.set({ 'c', 't' }, '<M-j>', '<C-n>', { desc = 'Recall more recent command-line from history' })
vim.keymap.set({ 'c', 't' }, '<M-k>', '<C-p>', { desc = 'Recall older command-line from history' })
vim.keymap.set({ 'c', 't' }, '∆', '<C-n>', { desc = 'Recall more recent command-line from history (macOS: Option-j)' })
vim.keymap.set({ 'c', 't' }, '˚', '<C-p>', { desc = 'Recall older command-line from history (macOS: Option-k)' })

-- Command mode
vim.keymap.set('c', 'kj', '<C-c>', { desc = 'Exit command mode' })
vim.keymap.set('c', '<Leader>P', '<C-r>0', { desc = 'Paste last yanked text' })
vim.keymap.set('c', '<Leader>PP', '<C-r>+', { desc = 'Paste system clipboard content' })

-- Insert mode
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', '<M-j>', '<Down>', { desc = 'Move downward' })
vim.keymap.set('i', '<M-k>', '<Up>', { desc = 'Move upward' })
vim.keymap.set('i', '∆', '<Down>', { desc = 'Move downward (macOS: Option-j)' })
vim.keymap.set('i', '˚', '<Up>', { desc = 'Move upward (macOS: Option-k)' })

-- Normal and Visual modes
vim.keymap.set({ 'n', 'x' }, '``', '``zz', { desc = 'Go to previous jump/mark and redraw line at center of window' })
vim.keymap.set({ 'n', 'x' }, '<C-d>', function()
  vim.o.scroll = vim.v.count1 == 1 and vim.o.scroll or vim.v.count1
  return '<Cmd>exe "norm!' .. vim.o.scroll .. 'j"<CR>zz'
end, { desc = "Scroll window 'scroll' amount downward (ignoring wrapped lines) and redraw line at center of window", expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-n>', '<C-n>zz', { desc = 'Go to [count] lines downward and redraw line at center of window' })
vim.keymap.set({ 'n', 'x' }, '<C-p>', '<C-p>zz', { desc = 'Go to [count] lines upward and redraw line at center of window' })
vim.keymap.set({ 'n', 'x' }, '<C-u>', function()
  vim.o.scroll = vim.v.count1 == 1 and vim.o.scroll or vim.v.count1
  return '<Cmd>exe "norm!' .. vim.o.scroll .. 'k"<CR>zz'
end, { desc = "Scroll window 'scroll' amount upward (ignoring wrapped lines) and redraw line at center of window", expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Leader>1', '1gt', { desc = 'Go to 1st tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>2', '2gt', { desc = 'Go to 2nd tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>3', '3gt', { desc = 'Go to 3rd tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>4', '4gt', { desc = 'Go to 4th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>5', '5gt', { desc = 'Go to 5th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>6', '6gt', { desc = 'Go to 6th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>7', '7gt', { desc = 'Go to 7th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>8', '8gt', { desc = 'Go to 8th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>9', '9gt', { desc = 'Go to 9th tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>;', 'q:', { desc = 'Open command mode history window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>e', ':<C-u>e ', { desc = 'Edit in current window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>en', '<Cmd>ene<CR>', { desc = 'a new, unnamed buffer' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fc', 'zc', { desc = 'Close one fold under the cursor' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fca', 'zM', { desc = 'Close all folds' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fcr', 'zC', { desc = 'Close all folds under the cursor recursively' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fo', 'zo', { desc = 'Open one fold under the cursor' })
vim.keymap.set({ 'n', 'x' }, '<Leader>foa', 'zR', { desc = 'Open all folds' })
vim.keymap.set({ 'n', 'x' }, '<Leader>for', 'zO', { desc = 'Open all folds under the cursor recursively' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ft', 'za', { desc = 'Toggle one fold under the cursor' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ftr', 'zA', { desc = 'Toggle all folds under the cursor recursively' })
vim.keymap.set({ 'n', 'x' }, '<Leader>h', '^', { desc = 'Go to first non-blank character of current line' })
vim.keymap.set({ 'n', 'x' }, '<Leader>il', '<Cmd>e $HOME/.config/nvim/init.lua<CR>', { desc = 'Edit init.lua' })
vim.keymap.set({ 'n', 'x' }, '<Leader>l', 'g_', { desc = 'Go to last non-blank character of current line and [count - 1] lines downward' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ln', function()
  local default_value = true
  vim.o.relativenumber = vim.o.relativenumber == false and default_value or false
  print('relativenumber = ' .. tostring(vim.o.relativenumber) .. ', number = ' .. tostring(vim.o.number))
end, { desc = 'Toggle hybrid line numbers' })
vim.keymap.set({ 'n', 'x' }, '<Leader>m', '<Cmd>marks<CR>:norm! `', { desc = 'List all marks and prompt return to unspecified mark' })
vim.keymap.set({ 'n', 'x' }, '<Leader>n', '<Cmd>bn<CR>', { desc = 'Go to next buffer' })
vim.keymap.set({ 'n', 'x' }, '<Leader>pb', '<Cmd>bp<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set({ 'n', 'x' }, '<Leader>s', function()
  local default_value = 5
  vim.o.scroll = vim.o.scroll == math.floor(vim.api.nvim_win_get_height(0) / 2) and default_value or 0
  print('scroll = ' .. vim.o.scroll .. ', height = ' .. vim.api.nvim_win_get_height(0))
end, { desc = "Cycle 'scroll' between 0 (half of window height) and 5 (my default)" })
vim.keymap.set({ 'n', 'x' }, '<Leader>so', function()
  local default_value = 3
  vim.o.scrolloff = vim.o.scrolloff == 0 and default_value or 0
  print('scrolloff = ' .. vim.o.scrolloff .. ', height = ' .. vim.api.nvim_win_get_height(0))
end, { desc = "Cycle 'scrolloff' between 0 and 3 (my default)" })
vim.keymap.set({ 'n', 'x' }, '<Leader><Tab>', '<C-^>', { desc = 'Switch between current and last buffer' })
vim.keymap.set({ 'n', 'x' }, '<Leader>tb', 'g<Tab>', { desc = 'Switch between current and last tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>te', '<Cmd>tabe<CR>', { desc = 'Edit in new tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>tn', '<Cmd>tabn<CR>', { desc = 'Go to next tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>tp', '<Cmd>tabp<CR>', { desc = 'Go to previous tab' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ul', '/\\v^(\\s*#)@!.+<CR>', { desc = 'Search for uncommented lines' })
vim.keymap.set({ 'n', 'x' }, '<Leader>w', function()
  local default_value = true
  vim.o.wrap = vim.o.wrap == false and default_value or false
  print('wrap = ' .. tostring(vim.o.wrap))
end, { desc = 'Toggle line wrap' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wb', '<C-w><C-p>', { desc = 'Switch between current and last window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wh', '<Cmd>new<CR>', { desc = 'Edit in new horizontally split window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wn', '<C-w>w', { desc = 'Go to next window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wp', '<C-w>W', { desc = 'Go to previous window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>wv', '<Cmd>vne<CR>', { desc = 'Edit in new vertically split window' })
vim.keymap.set({ 'n', 'x' }, '<Leader>zsh', ':<C-u>!', { desc = "Execute command with 'shell'" })
vim.keymap.set({ 'n', 'x' }, 'N', 'Nzz', { desc = 'Repeat the latest "/" or "?" [count] times in opposite direction and redraw line at center of window' })
vim.keymap.set({ 'n', 'x' }, 'n', 'nzz', { desc = 'Repeat the latest "/" or "?" [count] times and redraw line at center of window' })
vim.keymap.set({ 'n', 'x' }, '<S-Enter>', 'r<CR>', { desc = 'Replace the character under the cursor with <CR>' })
vim.keymap.set({ 'n', 'x' }, 'vv', '<C-v>', { desc = 'Enter visual mode blockwise' })

-- Normal mode
vim.keymap.set('n', '<Leader>[', '<<', { desc = "Shift [count] lines one 'shiftwidth' leftward" })
vim.keymap.set('n', '<Leader>]', '>>', { desc = "Shift [count] lines one 'shiftwidth' rightward" })
vim.keymap.set('n', '<Leader>bd', '<Cmd>bd<CR>', { desc = 'Delete current buffer' })
vim.keymap.set(
  'n',
  '<Leader>bd.',
  ":<C-u>ibufdo if (bufname() =~ '\\.$') <Bar> bd <Bar> endifF.a",
  { desc = 'Delete all buffers with a given filename extension' }
)
vim.keymap.set('n', '<Leader>bdh', '<Cmd>bp<Bar>sp<Bar>bn<Bar>bd<CR>', { desc = 'then open previous buffer and keep current horizontally split window' })
vim.keymap.set(
  'n',
  '<Leader>bdnt',
  "<Cmd>bufdo if (bufname() =~ '^\\(term://*\\)\\@!.') <Bar> bd <Bar> endif<CR>",
  { desc = 'Delete all non-terminal buffers' }
)
vim.keymap.set('n', '<Leader>bdv', '<Cmd>bp<Bar>vsp<Bar>bn<Bar>bd<CR>', { desc = 'then open previous buffer and keep current vertically split window' })
vim.keymap.set('n', '<Leader>bk', '<Cmd>bd!<CR>', { desc = 'Force delete current buffer' })
vim.keymap.set(
  'n',
  '<Leader>bk.',
  ":<C-u>ibufdo if (bufname() =~ '\\.$') <Bar> bd! <Bar> endifF.a",
  { desc = 'Force delete all buffers with a given filename extension' }
)
vim.keymap.set('n', '<Leader>bkh', '<Cmd>bp<Bar>sp<Bar>bn<Bar>bd!<CR>', { desc = 'then open previous buffer and keep current horizontally split window' })
vim.keymap.set(
  'n',
  '<Leader>bknt',
  "<Cmd>bufdo if (bufname() =~ '^\\(term://*\\)\\@!.') <Bar> bd! <Bar> endif<CR>",
  { desc = 'Force delete all non-terminal buffers' }
)
vim.keymap.set('n', '<Leader>bkv', '<Cmd>bp<Bar>vsp<Bar>bn<Bar>bd!<CR>', { desc = 'then open previous buffer and keep current vertically split window' })
vim.keymap.set('n', '<Leader>ch', '<Cmd>che<CR>', { desc = 'Run all healthchecks' })
vim.keymap.set('n', '<Leader>db', '<Cmd>Alpha<CR>', { desc = "Open alpha.nvim's dashboard buffer" })
vim.keymap.set(
  'n',
  '<Leader>eftel',
  '<Cmd>cd $HOME/.config/emacs/elisp/packages<Bar>ene<Bar>%!echo ";;; ~/.config/emacs/elisp/packages/.el\\n;;;\\n;;; https://github.com/username/repository"<CR>:<C-u>iw .elF.i',
  { desc = 'an Emacs package-configuration file-template' }
)
vim.keymap.set(
  'n',
  '<Leader>eftp',
  "<Cmd>cd $HOME/.config/nvim/lua/custom/plugins<Bar>ene<Bar>%!echo \"-- ~/.config/nvim/lua/custom/plugins/.lua\\n--\\n-- https://github.com/username/repository\\nreturn {\\n  'username/repository',\\n  opts = {},\\n  config = function(_, opts)\\n    require('plugin').setup(opts)\\n  end,\\n}\"<CR>:<C-u>iw .luaF.i",
  { desc = 'a Neovim plugin-configuration file-template' }
)
vim.keymap.set(
  'n',
  '<Leader>eftsty',
  '<Cmd>cd $HOME/Library/texmf/tex/latex<Bar>ene<Bar>%!echo "\\% ~/Library/texmf/tex/latex/package/package.sty\\n\\NeedsTeXFormat{LaTeX2e}\\n\\ProvidesPackage{package}[2020/00/00 Description]\\n\\n\\\\\\\\endinput"<CR>:<C-u>iw ++p .styF.i',
  { desc = 'a LaTeX-package file-template' }
)
vim.keymap.set('n', '<Leader>j', function()
  local recenter = vim.v.count1 == 1 and 'zz' or (vim.v.count1 - 1) .. 'jzz'
  return '<Cmd>exe "norm' .. vim.v.count1 .. 'gcc"<CR>' .. recenter
end, { desc = 'Comment or uncomment [count] lines starting at cursor and redraw line at center of window', expr = true, silent = true })
vim.keymap.set('n', '<Leader>k', function()
  local current_line_or_motion = vim.v.count1 == 1 and 'c' or (vim.v.count1 - 1) .. 'k'
  return '<Cmd>exe "norm gc' .. current_line_or_motion .. '"<CR>zz'
end, { desc = 'Comment or uncomment [count] lines backward starting at cursor and redraw line at center of window', expr = true, silent = true })
vim.keymap.set('n', '<Leader>lz', '<Cmd>Lazy<CR>', { desc = 'Open lazy.nvim plugin list' })
vim.keymap.set(
  'n',
  '<Leader>map',
  '<Cmd>redir @a<Bar>silent map<Bar>redir END<Bar>new<Bar>put a<CR>',
  { desc = "Edit output of ':map' in new horizontally split window" }
)
vim.keymap.set('n', '<Leader>ph', '<Cmd>Hardtime toggle<CR>', { desc = 'Toggle hardtime.nvim plugin' })
vim.keymap.set('n', '<Leader>pp', '<Cmd>Precognition toggle<CR>', { desc = 'Toggle precognition.nvim plugin' })
vim.keymap.set(
  'n',
  '<Leader>prcwo',
  ':<C-u>%s;\\vconfig \\= function\\(\\)\\_.{-}require\\(.{-}\\)\\.setup\\((\\{\\_.{-}\\})\\)\\_.{-}end(,)?;opts = \\1\\2',
  { desc = "Replace 'config = function() require(<plugin>).setup({})' with 'opts = {}'" }
)
vim.keymap.set(
  'n',
  '<Leader>prfn',
  ':<C-u>1s;\\v(/plugins/)@<=.{-}(\\.lua)@=;',
  { desc = 'Replace filename comment in Neovim plugin-configuration file-template' }
)
vim.keymap.set(
  'n',
  '<Leader>prit',
  ':<C-u>4,$s;\\v(\\{\\_.)@<=\\_.*(\\})@=;\\=@+',
  { desc = 'Replace inside of table with clipboard contents in Neovim plugin-configuration file-template' }
)
vim.keymap.set(
  'n',
  '<Leader>prrl',
  ":<C-u>3,4s;\\v(github\\.com/)@<=.{-}($\\_.{-}'(.{-})')@=;\\3",
  { desc = 'Replace repository link comment in Neovim plugin-configuration file-template' }
)
vim.keymap.set('n', '<Leader>ps', '<Cmd>Screenkey toggle<CR>', { desc = 'Toggle screenkey.nvim plugin' })
vim.keymap.set('n', '<Leader>qs', function()
  require('persistence').load()
end, { desc = 'Load the session for the current directory' })
vim.keymap.set('n', '<Leader>qS', function()
  require('persistence').select()
end, { desc = 'Select a session to load' })
vim.keymap.set('n', '<Leader>ql', function()
  require('persistence').load { last = true }
end, { desc = 'Load the last session' })
vim.keymap.set('n', '<Leader>qd', function()
  require('persistence').stop()
end, { desc = "Stop Persistence => session won't be saved on exit" })
vim.keymap.set('n', '<Leader>qw', '<Cmd>q<CR>', { desc = 'Quit current window' })
vim.keymap.set('n', '<Leader>r\\', ':<C-u>s;\\\\;\\\\\\\\;g', { desc = 'Replace backslashes with escaped ones' })
vim.keymap.set('n', '<Leader>rf+0', '<Cmd>let @+=@0<CR>', { desc = "Fill register '+' with contents of register '0'" })
vim.keymap.set('n', '<Leader>rf0+', '<Cmd>let @0=@+<CR>', { desc = "Fill register '0' with contents of register '+'" })
vim.keymap.set('n', '<Leader>rfab', ':<C-u>ilet @a=@bFa', { desc = "Fill register 'a' with contents of register 'b'" })
vim.keymap.set('n', '<Leader>rr+n', '<Cmd>let @+=substitute(strtrans(@+),"\\^@"," ","g")<CR>', { desc = "Replace newlines in register '+' with spaces" })
vim.keymap.set('n', '<Leader>rr0n', '<Cmd>let @0=substitute(strtrans(@0),"\\^@"," ","g")<CR>', { desc = "Replace newlines in register '0' with spaces" })
vim.keymap.set('n', '<Leader>rran', ':<C-u>ilet @a=substitute(strtrans(@a),"\\^@"," ","g")3Fa', { desc = "Replace newlines in register 'a' with spaces" })
vim.keymap.set('n', '<Leader>styrfn', ':<C-u>i1,3s;\\Cpackage;;gF;i', { desc = 'Replace filename comment in LaTeX package file template' })
vim.keymap.set('n', '<Leader>tc', '<Cmd>tabc<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<Leader>wc', '<Cmd>clo<CR>', { desc = 'Close current window' })
vim.keymap.set('n', '<Leader>yap', '<Cmd>let @+=expand("%:p")<CR>', { desc = 'Yank absolute path of current file' })
vim.keymap.set('n', '<Leader>ydn', '<Cmd>let @+=expand("%:p:h")<CR>', { desc = 'Yank directory name of current file' })
vim.keymap.set('n', '<Leader>yfn', '<Cmd>let @+=expand("%:t")<CR>', { desc = 'Yank filename of current file' })
vim.keymap.set('n', '<Leader>yrp', '<Cmd>let @+=expand("%")<CR>', { desc = 'Yank relative path of current file' })

-- Terminal mode
vim.keymap.set('t', 'kj', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Visual mode
vim.keymap.set('x', 'kj', '<Esc>', { desc = 'Exit visual mode' })
vim.keymap.set('x', '<Leader>[', '<', { desc = "Shift the highlighted lines [count] 'shiftwidth' leftward" })
vim.keymap.set('x', '<Leader>]', '>', { desc = "Shift the highlighted lines [count] 'shiftwidth' rightward" })
vim.keymap.set(
  'x',
  '<Leader>j',
  'ml<Cmd>exe "norm gc"<CR>`lzz',
  { desc = 'Comment or uncomment the selected line(s), return to last cursor position, and redraw line at center of window' }
)
vim.keymap.set('x', 'P', 'p', { desc = 'Put without changing unnamed register in visual mode' })
vim.keymap.set('x', 'p', 'P', { desc = 'Put and change unnamed register with selection in visual mode' })
vim.keymap.set('x', 'Y', 'mlY`lzz', { desc = 'Yank the highlighted lines, return to last cursor position, and redraw line at center of window' })
vim.keymap.set('x', 'y', 'mly`lzz', { desc = 'Yank the highlighted text, return to last cursor position, and redraw line at center of window' })

-- [[ Indentation ]]
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- [[ Folds ]]
-- Sources:
-- https://stackoverflow.com/a/77180744

-- Autosave folds
vim.api.nvim_create_autocmd('BufWinLeave', {
  group = vim.api.nvim_create_augroup('save-folds', { clear = true }),
  pattern = { '*.*' },
  desc = 'Save view (folds), when closing file',
  command = 'mkview',
})
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('load-folds', { clear = true }),
  pattern = { '*.*' },
  desc = 'Load view (folds), when opening file',
  command = 'silent! loadview',
})

-- Remove fillchars
vim.o.fillchars = 'fold: '

-- [[ Neovide configurations which are not already configured in ~/.config/neovide/config.toml ]]
if vim.g.neovide then
  -- Animation trail size | https://neovide.dev/configuration.html#animation-trail-size
  vim.g.neovide_cursor_trail_size = 1.0
  -- Fullscreen | https://neovide.dev/configuration.html#fullscreen
  vim.g.neovide_fullscreen = true
  -- GUI cursor options | https://neovim.io/doc/user/options.html#'guicursor'
  vim.opt.guicursor = {
    'n-c-o-sm-v-ve:block',
    'ci-i-t:ver25',
    'r-cr:hor20',
  }
end
