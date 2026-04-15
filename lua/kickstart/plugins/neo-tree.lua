-- ~/.config/nvims/kickstart/lua/kickstart/plugins/neo-tree.lua
-- Neovim plugin to manage the file system and other tree-like structures
-- https://github.com/nvim-neo-tree/neo-tree.nvim
---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'nvim-lua/plenary.nvim',
  },
  lazy = false,
  keys = {
    -- Sources:
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/826#discussioncomment-5431757
    {
      '\\',
      function()
        local manager = require 'neo-tree.sources.manager'
        local renderer = require 'neo-tree.ui.renderer'

        local state = manager.get_state 'filesystem'
        local window_exists = renderer.window_exists(state)
        if window_exists then
          vim.cmd 'Neotree toggle'
        else
          vim.cmd 'Neotree reveal_force_cwd'
        end
      end,
      desc = 'Open Neo-tree filesystem sidebar and reveal current file without prompting if it is closed, and close if otherwise',
      silent = true,
    },
    {
      '<Leader>\\',
      '<Cmd>Neotree toggle<CR>',
      desc = 'Open Neo-tree filesystem sidebar in last directory set as root if it is closed, and close if otherwise',
      silent = true,
    },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'document_symbols',
    },
    source_selector = {
      winbar = true,
      sources = {
        { source = 'filesystem', display_name = ' 󰉓 File ' },
        { source = 'git_status', display_name = ' 󰊢 Git ' },
        { source = 'buffers', display_name = ' 󰓩 Buf ' },
        { source = 'document_symbols', display_name = '  Sym ' },
      },
      content_layout = 'center',
    },
    filesystem = {
      bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
      cwd_target = {
        sidebar = 'tab', -- sidebar is when position = left or right
        current = 'window', -- current is when position = current
      },
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          '.DS_Store',
          '.git',
          -- 'thumbs.db',
        },
        never_show = {},
      },
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      window = {
        mappings = {
          ['o'] = 'system_open',
        },
      },
    },
    buffers = {
      bind_to_cwd = true,
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --              -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
    },
    commands = {
      -- Sources:
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-6679447
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#open-with-system-viewer
      --
      -- Copy path or name of file or directory under cursor
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local vals = {
          ['BASENAME'] = modify(filename, ':r'),
          ['EXTENSION'] = modify(filename, ':e'),
          ['FILENAME'] = filename,
          ['PATH (CWD)'] = modify(filepath, ':.'),
          ['PATH (HOME)'] = modify(filepath, ':~'),
          ['PATH'] = filepath,
          ['URI'] = vim.uri_from_fname(filepath),
        }

        local options = vim.tbl_filter(function(val) return vals[val] ~= '' end, vim.tbl_keys(vals))
        if vim.tbl_isempty(options) then
          vim.notify('No values to copy', vim.log.levels.WARN)
          return
        end
        table.sort(options)
        vim.ui.select(options, {
          prompt = 'Choose to copy to clipboard:',
          format_item = function(item) return ('%s: %s'):format(item, vals[item]) end,
        }, function(choice)
          local result = vals[choice]
          if result then
            vim.notify(('Copied: `%s`'):format(result))
            vim.fn.setreg('+', result)
          end
        end)
      end,
      --
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        vim.fn.jobstart({ 'open', path }, { detach = true })
      end,
    },
    window = {
      mappings = {
        -- Sources:
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/163#discussioncomment-4747082
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/163#discussioncomment-7663286
        --
        -- Jump up to parent directory on file or closed directory, or close on open directory
        ['\\'] = 'close_window',
        ['h'] = function(state)
          local node = state.tree:get_node()
          if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
          end
        end,
        -- Open on file or closed directory, or jump down to top subdirectory on open directory
        ['l'] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' or node:has_children() then
            if not node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
            end
          else
            require('neo-tree.sources.filesystem.commands').open(state)
          end
        end,
        ['<Leader><Tab>'] = 'close_window',
        ['<S-Tab>'] = 'prev_source',
        ['<Tab>'] = 'next_source',
        ['Y'] = 'copy_selector',
      },
    },
  },
  config = function(_, opts) require('neo-tree').setup(opts) end,
}

-- vim: et sts=2 sw=2 ts=2
