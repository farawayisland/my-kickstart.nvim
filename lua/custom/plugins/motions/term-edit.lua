-- ~/.config/nvims/kickstart/lua/custom/plugins/motions/term-edit.lua
-- Vim Keybindings in Neovim's Built-in Terminal
-- https://github.com/chomosuke/term-edit.nvim
return {
  'chomosuke/term-edit.nvim',
  event = 'TermOpen',
  opts = {
    -- Mandatory option:
    -- Set this to a lua pattern that would match the end of your prompt.
    -- Or a table of multiple lua patterns where at least one would match the
    -- end of your prompt at any given time.
    -- For most bash/zsh user this is '%$ '.
    -- For most powershell/fish user this is '> '.
    -- For most windows cmd user this is '>'.
    mapping = {
      n = {
        s = false,
      },
    },
    prompt_end = '%$ ',
    -- How to write lua patterns: https://www.lua.org/pil/20.2.html
  },
  version = '1.*',
}

-- vim: et sts=2 sw=2 ts=2
