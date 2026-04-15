-- ~/.config/nvims/kickstart/lua/custom/plugins/graphics/image.lua
-- Adds image support to Neovim using kitty's graphics protocol or ueberzugpp
-- https://github.com/3rd/image.nvim
return {
  '3rd/image.nvim',
  build = false, -- So that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    -- Sources:
    -- https://github.com/3rd/image.nvim?tab=readme-ov-file#plugin-installation
    -- https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md
    backend = 'kitty',
    editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
    hijack_file_patterns = { '*.avif', '*.gif', '*.jpeg', '*.jpg', '*.png', '*.webp' }, -- render image files as images when opened
    integrations = {
      css = {
        enabled = false,
      },
      html = {
        enabled = false,
      },
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
        floating_windows = false, -- if true, images will be rendered in floating markdown windows
        only_render_image_at_cursor = false,
        only_render_image_at_cursor_mode = 'popup', -- or "inline"
      },
      neorg = {
        enabled = true,
        filetypes = { 'norg' },
      },
      typst = {
        enabled = true,
        filetypes = { 'typst' },
      },
    },
    max_height = 500,
    max_height_window_percentage = math.huge,
    max_width = 500,
    max_width_window_percentage = math.huge,
    processor = 'magick_cli',
    scale_factor = 1.0,
    tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', 'snacks_notif', 'scrollview', 'scrollview_sign', '' },
  },
}

-- vim: et sts=2 sw=2 ts=2
