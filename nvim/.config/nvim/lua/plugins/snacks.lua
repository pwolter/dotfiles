-- Inline image rendering (markdown, Obsidian notes, standalone image files)
-- Requires a terminal with the Kitty graphics protocol (Ghostty, Kitty, WezTerm)
-- and ImageMagick (`magick`) for format conversion
return {
  -- https://github.com/folke/snacks.nvim/blob/main/docs/image.md
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = {
      enabled = true,
      doc = {
        -- Render images inline in markdown; set inline = false to show them in a float on hover
        inline = true,
        float = true,
        -- Size caps in terminal cells; images are also limited by the window size
        -- and are never upscaled past their native resolution
        max_width = 200,
        max_height = 60,
      },
      -- Obsidian embeds (![[Pasted image ...png]]) are relative to the vault's
      -- attachment folder, not the note, so look there when inside a vault
      resolve = function(file, src)
        local vault = vim.fs.root(file, ".obsidian")
        if not vault then
          return nil
        end
        local attachments = "Attachments"
        local ok, app = pcall(function()
          return vim.json.decode(table.concat(vim.fn.readfile(vault .. "/.obsidian/app.json"), "\n"))
        end)
        if ok and type(app) == "table" and app.attachmentFolderPath then
          attachments = app.attachmentFolderPath
        end
        for _, path in ipairs({ vault .. "/" .. attachments .. "/" .. src, vault .. "/" .. src }) do
          if vim.fn.filereadable(path) == 1 then
            return path
          end
        end
      end,
    },
  },
  keys = {
    { "<leader>ip", function() Snacks.image.hover() end, desc = "Preview image under cursor" },
  },
}
