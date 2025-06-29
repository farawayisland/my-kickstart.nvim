-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MagicDuck/grug-far.nvim',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal_force_cwd<CR>', desc = 'Display Neo-tree sidebar and reveal current file without prompting', silent = true },
    { '<Leader>\\', ':Neotree<CR>', desc = 'Display Neo-tree sidebar of the last directory set as root', silent = true },
  },
  opts = {
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
          ['\\'] = 'close_window',
          ['<Leader><Tab>'] = 'close_window',
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
      -- create a new neo-tree command
      grug_far_replace = function(state)
        local node = state.tree:get_node()
        local prefills = {
          -- also escape the paths if space is there
          -- if you want files to be selected, use ':p' only, see filename-modifiers
          paths = node.type == 'directory' and vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ':p'))
            or vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ':h')),
        }
        open_grug_far(prefills)
      end,
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/fbb631e818f48591d0c3a590817003d36d0de691/doc/neo-tree.txt#L535
      grug_far_replace_visual = function(state, selected_nodes, callback)
        local paths = {}
        for _, node in pairs(selected_nodes) do
          -- also escape the paths if space is there
          -- if you want files to be selected, use ':p' only, see filename-modifiers
          local path = node.type == 'directory' and vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ':p'))
            or vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ':h'))
          table.insert(paths, path)
        end
        local prefills = { paths = table.concat(paths, '\n') }
        open_grug_far(prefills)
      end,
    },
    window = {
      mappings = {
        z = 'grug_far_replace',
      },
    },
  },
  config = function(_, opts)
    local function open_grug_far(prefills)
      local grug_far = require 'grug-far'

      if not grug_far.has_instance 'explorer' then
        grug_far.open { instanceName = 'explorer' }
      else
        grug_far.get_instance('explorer'):open()
      end
      -- doing it seperately because multiple paths doesn't open work when passed with open
      -- updating the prefills without clearing the search and other fields
      grug_far.get_instance('explorer'):update_input_values(prefills, false)
    end
    require('neo-tree').setup(opts)
    -- vim.o.autochdir = true
  end,
}
