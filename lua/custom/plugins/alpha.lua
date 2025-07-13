-- ~/.config/nvim/lua/custom/plugins/alpha.lua
-- A Lua-powered greeter
-- https://github.com/goolord/alpha-nvim
return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'
    local neovim = [[
           ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗           
           ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║           
           ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║           
           ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║           
           ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║           
           ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝           
    ]]
    local logo = neovim
    dashboard.section.header.val = vim.split(logo, '\n')
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button('f', ' ' .. ' Find file',       "<Cmd>lua require('telescope.builtin').find_files()<CR>"),
      dashboard.button('n', ' ' .. ' New file',        '<Cmd>ene<Bar>startinsert<CR>'),
      dashboard.button('r', ' ' .. ' Recent files',    "<Cmd>lua require('telescope.builtin').oldfiles()<CR>"),
      dashboard.button('g', ' ' .. ' Find text',       "<Cmd>lua require('telescope.builtin').live_grep()<CR>"),
      dashboard.button('c', ' ' .. ' Config',          "<Cmd>lua require('telescope.builtin').find_files{cwd=vim.fn.stdpath'config'}<CR>"),
      dashboard.button('s', ' ' .. ' Restore Session', "<Cmd>lua require('persistence').load()<CR>"),
      dashboard.button('l', '󰒲 ' .. ' Lazy',            '<Cmd>Lazy<cr>'),
      dashboard.button('q', ' ' .. ' Quit',            '<Cmd>qa<CR>'),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'AlphaReady',
        desc = 'Re-open when the dashboard is ready, after closing Lazy',
        callback = function()
          require('lazy').show()
        end,
      })
    end
    require('alpha').setup(dashboard.opts)
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('disable-status-line-and-ruler', { clear = true }),
      pattern = 'AlphaReady',
      desc = 'Disable both status line and ruler when opening alpha buffer',
      callback = function()
        vim.o.laststatus = 0
        vim.o.ruler = false
      end,
    })
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('disable-folding', { clear = true }),
      pattern = 'alpha',
      desc = 'Disable folding in alpha buffer',
      command = [[
        setlocal foldmethod=indent
        setlocal nofoldenable
      ]],
    })
    vim.api.nvim_create_autocmd('UIEnter', {
      once = true,
      desc = 'Show lazy.nvim startup statistics',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('enable-status-line-and-ruler', { clear = true }),
      pattern = 'AlphaClosed',
      desc = 'Enable both status line and ruler when closing alpha buffer',
      callback = function()
        vim.o.laststatus = 2
        vim.o.ruler = true
      end,
    })
  end,
}
