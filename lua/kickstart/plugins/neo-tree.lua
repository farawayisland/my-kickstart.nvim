-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
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
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.o.autochdir = true
  end,
}
