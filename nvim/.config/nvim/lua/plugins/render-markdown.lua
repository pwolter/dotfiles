-- In-editor Markdown rendering (headings, tables, code blocks, bullets, …)
return {
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    -- Needs the markdown / markdown_inline treesitter parsers
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    code = {
      -- Default 'hide' conceals the ``` fence lines, which also hides images
      -- snacks.image attaches to them (Mermaid diagrams); draw thin borders instead
      border = 'thin',
    },
  },
}
