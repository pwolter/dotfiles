local M = {}

function M.paste_image_and_save()
  -- Using the Lua API instead of the PasteImage command because it returns a
  -- boolean indicating whether an image was pasted
  -- https://github.com/HakonHarnes/img-clip.nvim/blob/main/README.md#api
  local pasted_image = require("img-clip").paste_image()
  if pasted_image then
    -- "update" saves only if the buffer has been modified since the last save
    vim.cmd("update")
    print("Image pasted and file saved")
    -- Reloads the file to reflect the changes
    vim.cmd("edit!")
    -- Switch back to normal mode
    vim.cmd("stopinsert")
  else
    print("No image pasted. File not updated.")
  end
end

return M
