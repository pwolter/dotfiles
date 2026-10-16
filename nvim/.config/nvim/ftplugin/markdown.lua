-- Markdown specific settings
-- opt_local / buffer = true keep these in markdown buffers; vim.opt and global
-- maps leaked them into every file opened afterwards
vim.opt_local.wrap = true -- Wrap text
vim.opt_local.breakindent = true -- Match indent on line break
vim.opt_local.linebreak = true -- Line break on whole words

-- Allow j/k when navigating wrapped lines
vim.keymap.set("n", "j", "gj", { buffer = true })
vim.keymap.set("n", "k", "gk", { buffer = true })

-- Spell check
vim.opt_local.spelllang = 'en_us'
vim.opt_local.spell = true

-- Paste image from clipboard, then save and reload (markdown only, so <C-a>
-- keeps incrementing numbers everywhere else)
vim.keymap.set({ "n", "v", "i" }, "<C-a>", function()
  -- Call the paste_image function from the Lua API
  -- Using the plugin's Lua API (require("img-clip").paste_image()) instead of the
  -- PasteImage command because the Lua API returns a boolean value indicating
  -- whether an image was pasted successfully or not.
  -- The PasteImage command does not
  -- https://github.com/HakonHarnes/img-clip.nvim/blob/main/README.md#api
  local pasted_image = require("img-clip").paste_image()
  if pasted_image then
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("update")
    print("Image pasted and file saved")
    -- Reloads the file to reflect the changes
    vim.cmd("edit!")
    -- Switch back to command mode
    vim.cmd("stopinsert")
  else
    print("No image pasted. File not updated.")
  end
end, { buffer = true, desc = "Paste image from system clipboard" })
