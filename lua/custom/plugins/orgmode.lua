-- ~/.config/nvim/lua/custom/plugins/orgmode.lua
--
-- https://github.com/nvim-orgmode/orgmode
return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  opts = {
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/refile.org',
  },
}
