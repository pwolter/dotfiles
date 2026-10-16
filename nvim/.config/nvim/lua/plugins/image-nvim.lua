-- Image backend for molten-nvim's plot outputs (molten can't use snacks.nvim).
-- Markdown/document images stay with snacks.nvim, so integrations are off here.
return {
  -- https://github.com/3rd/image.nvim
  "3rd/image.nvim",
  build = false, -- skip the magick luarock; the magick CLI is used instead
  lazy = true,
  opts = {
    backend = "kitty", -- Ghostty speaks the Kitty graphics protocol
    processor = "magick_cli",
    integrations = {
      markdown = { enabled = false },
      neorg = { enabled = false },
      typst = { enabled = false },
      html = { enabled = false },
      css = { enabled = false },
    },
    max_width = 100,
    max_height = 12,
    max_height_window_percentage = math.huge, -- let molten size the output window
    max_width_window_percentage = math.huge,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "" },
  },
}
