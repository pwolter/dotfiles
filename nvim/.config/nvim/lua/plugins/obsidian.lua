return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Pablo",
        path = "~/Documents/Pablo",
        overrides = {
          notes_subdir = "Notes",
        },
      },
    },
    -- Disable Obsidian's own concealing/rendering; render-markdown.nvim is the
    -- single markdown renderer (avoids double-conceal conflicts on notes).
    ui = { enable = false },
  },
}
