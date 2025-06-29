-- ~/.config/nvim/lua/custom/plugins/vimtex.lua
-- A modern Vim and Neovim filetype plugin for LaTeX files
-- https://github.com/lervag/vimtex
return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.cmd 'filetype plugin indent on'
    vim.cmd 'syntax enable'
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_compile_latexmk = {
      continuous = { 0 },
      executable = 'latexmk',
      options = {
        '-file-line-error',
        '-interactions=nonstopmode',
        '-synctex=1',
      },
    }
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-lualatex',
    }
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
    vim.g.vimtex_quickfix_mode = 2
    vim.g.vimtex_view_method = 'sioyek'
  end,
}
