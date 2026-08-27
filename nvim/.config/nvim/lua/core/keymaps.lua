-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" }) -- save and quit
keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "Quit without saving" }) -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Save" }) -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>", { desc = "Open URL under cursor" }) -- open URL under cursor

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" }) -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split window" }) -- close split window
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "Make split window height shorter" }) -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "Make split window height taller" }) -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5", { desc = "Make split windows width bigger" }) -- make split windows width bigger 
keymap.set("n", "<leader>sh", "<C-w><5", { desc = "Make split windows width smaller" }) -- make split windows width smaller
keymap.set("n", "<leader>sml", "<C-w>l", { desc = "Move to right split window" })
keymap.set("n", "<leader>smh", "<C-w>h", { desc = "Move to left split window" })
keymap.set("n", "<leader>smj", "<C-w>h", { desc = "Move to down split window" })
keymap.set("n", "<leader>smk", "<C-w>h", { desc = "Move to up split window" })

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open in new tab" }) -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" }) -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" }) -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" }) -- previous tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>", { desc = "Put diff from current to other during diff" }) -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>", { desc = "Get diff from left (local) during merge" }) -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>", { desc = "Get diff from right (remote) during merge" }) -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c", { desc = "Next diff hunk" }) -- next diff hunk
keymap.set("n", "<leader>cp", "[c", { desc = "Previous diff hunk" }) -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" }) -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = "Jump to first quickfix list item" }) -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Jump to next quickfix list item" }) -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Jump to prev quickfix list item" }) -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>", { desc = "Jump to last quickfix list item" }) -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" }) -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle maximize tab" }) -- toggle maximize tab

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>", { desc = "Toggle focus to file explorer" }) -- toggle focus to file explorer
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Find file in file explorer" }) -- find file in file explorer

-- Telescope
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find files in current working dir" })
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Search for string in current woring dir" })
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "List open buffers" })
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "List available help tags" })
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, { desc = "Live fuzzy search in current buffer" })
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, { desc = "List LSP document symbols in workspace" })
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, { desc = "List LSP incoming calls for word under cursor" })
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end, { desc = "Lists method" })
keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = "Find TODOs" })
keymap.set('n', '<leader>fl', '<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>', { desc = "Open/List Telescope buffers" })

-- Git-blame
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Toggle git blame" }) -- toggle git blame

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>", { desc = "Run REST query" }) -- Run REST query

-- LSP
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "Displays hover information" })
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Jumps to the definition of the symbol" })
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Jumps to the declaration" })
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "List all the implementations" })
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Jumps to the definition of the type" })
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "Lists all the references to the symbol" })
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Displays signature information" })
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "Renames all references to the symbol" })
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "Formats the buffer" })
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Selects a code action" })
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Show diagnostics in a floating window" })
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.get_prev()<CR>', { desc = "Get the previous diagnostic" })
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.get_next()<CR>', { desc = "Get the next diagnostic" })
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { desc = "Lists all symbols in current buffer" })
keymap.set('n', '<leader>td', function () vim.diagnostic.enable(not vim.diagnostic.is_enabled()); end, { desc = "Disable diagnostic" })
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>', { desc = "Retrieves the completion items" })

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "Set breakpoint condition" })
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { desc = "Set breakpoint message" })
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "Clear breakpoint" })
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "List all breakpoints" })
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Continue" })
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step over" })
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step into" })
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step out" })
keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end, { desc = "Disconnect" })
keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end, { desc = "Terminate" })
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "Toggle REPL" })
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "Run last" })
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end, { desc = "Widget hover" })
keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end, { desc = "Center floating Widget" })
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>', { desc = "Telescope dap frames" })
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>', { desc = "Telescope dap commands" })
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end, { desc = "Telescope diagnostics E" })

-- Markdown preview
keymap.set("n", '<leader>mp', ':MarkdownPreview<CR>', { desc = "Markdown preview" })
keymap.set("n", '<leader>ms', ':MarkdownPreviewStop<CR>', { desc = "Markdown preview stop" })
keymap.set("n", '<leader>mt', ':MarkdownPreviewToggle<CR>', { desc = "Markdown preview toggle" })

-- Markdown
keymap.set("n", "<leader>mre", function () require("render-markdown").enable() end, { desc = "Markdoen render - enable" })
keymap.set("n", "<leader>mrd", function () require("render-markdown").disable() end, { desc = "Markdoen render - disable" })
keymap.set("n", "<leader>mrt", function () require("render-markdown").toggle() end, { desc = "Markdoen render - toggle" })
keymap.set("n", "<leader>mse", function () vim.opt.spelllang = "en" vim.cmd("echo 'Spell language set to English'") end, { desc = "Markdoen language English" })
keymap.set("n", "<leader>mss", function () vim.opt.spelllang = "es" vim.cmd("echo 'Spell language set to Spanish'") end, { desc = "Markdoen language Spanish" })
keymap.set("n", "<leader>msb", function () vim.opt.spelllang = "en,es" vim.cmd("echo 'Spell language set to English and Spanish'") end, { desc = "Markdoen language English and Spanish" })


-- Obsidian
keymap.set("n", "<leader>oo", ':ObsidianOpen<CR>', { desc = "Open note in Obsidian" })
keymap.set("n", "<leader>on", ':ObsidianNew<CR>', { desc = "Create a new Obsidian note" })
keymap.set("n", "<leader>os", ':ObsidianQuickSwitch<CR>', { desc = "Quick switch or create a note" })
keymap.set("n", "<leader>olv", ':ObsidianFollowLink vsplit<CR>', { desc = "Follow a note reference under the cursor vsplit" })
keymap.set("n", "<leader>olh", ':ObsidianFollowLink hsplit<CR>', { desc = "Follow a note reference under the cursor hsplit" })
keymap.set("n", "<leader>ot", ':ObsidianTemplate<CR>', { desc = "Insert a template from the templare folder" })
keymap.set("n", "<leader>oi", ':ObsidianPasteImg<CR>', { desc = "Paste an image from the clipboard" })
keymap.set("n", "<leader>oc", ':ObsidianToggleCheckbox<CR>', { desc = "Cycle through checkbox options" })
keymap.set("n", "<leader>of", ':ObsidianSearch<CR>', { desc = "Search (or create) notes" })


-- Images
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
    -- Only if updated I'll refresh the images by clearing them first
    -- I'm using [[ ]] to escape the special characters in a command
    vim.cmd([[lua require("image").clear()]])
    -- Reloads the file to reflect the changes
    vim.cmd("edit!")
    -- Switch back to command mode
    vim.cmd("stopinsert")
  else
    print("No image pasted. File not updated.")
  end
end, { desc = "Paste image from system clipboard" })

-- Open image under cursor in the Preview app (macOS)
vim.keymap.set("n", "<leader>io", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      print("URL image, use 'gx' to open it in the default browser.")
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h")
      local absolute_image_path = current_file_path .. "/" .. image_path

      -- Construct command to open image in Preview
      local command = "open -a Preview " .. vim.fn.shellescape(absolute_image_path)
      -- Execute the command
      local success = os.execute(command)

      if success then
        print("Opened image in Preview: " .. absolute_image_path)
      else
        print("Failed to open image in Preview: " .. absolute_image_path)
      end
    end
  else
    print("No image found under the cursor")
  end
end, { desc = "(macOS) Open image under cursor in Preview" })

vim.keymap.set("n", "<leader>if", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      print("URL image, use 'gx' to open it in the default browser.")
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h")
      local absolute_image_path = current_file_path .. "/" .. image_path

      -- Open the containing folder in Finder and select the image file
      local command = "open -R " .. vim.fn.shellescape(absolute_image_path)
      local success = vim.fn.system(command)

      if success == 0 then
        print("Opened image in Finder: " .. absolute_image_path)
      else
        print("Failed to open image in Finder: " .. absolute_image_path)
      end
    end
  else
    print("No image found under the cursor")
  end
end, { desc = "(macOS) Open image under cursor in Finder" })

vim.keymap.set("n", "<leader>id", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      vim.api.nvim_echo({
        { "URL image cannot be deleted from disk.", "WarningMsg" },
      }, false, {})
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h")
      local absolute_image_path = current_file_path .. "/" .. image_path

      -- Check if trash utility is installed
      if vim.fn.executable("trash") == 0 then
        vim.api.nvim_echo({
          { "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
          { "- In macOS run `brew install trash`\n", nil },
        }, false, {})
        return
      end

      -- Prompt for confirmation before deleting the image
      vim.ui.input({
        prompt = "Delete image file? (y/n) ",
      }, function(input)
        if input == "y" or input == "Y" then
          -- Delete the image file using trash app
          local success, _ = pcall(function()
            vim.fn.system({ "trash", vim.fn.fnameescape(absolute_image_path) })
          end)

          if success then
            vim.api.nvim_echo({
              { "Image file deleted from disk:\n", "Normal" },
              { absolute_image_path, "Normal" },
            }, false, {})
            -- I'll refresh the images, but will clear them first
            -- I'm using [[ ]] to escape the special characters in a command
            vim.cmd([[lua require("image").clear()]])
            -- Reloads the file to reflect the changes
            vim.cmd("edit!")
          else
            vim.api.nvim_echo({
              { "Failed to delete image file:\n", "ErrorMsg" },
              { absolute_image_path, "ErrorMsg" },
            }, false, {})
          end
        else
          vim.api.nvim_echo({
            { "Image deletion canceled.", "Normal" },
          }, false, {})
        end
      end)
    end
  else
    vim.api.nvim_echo({
      { "No image found under the cursor", "WarningMsg" },
    }, false, {})
  end
end, { desc = "(macOS) Delete image file under cursor" })
