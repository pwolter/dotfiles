-- Run notebook cells against a Jupyter kernel, with outputs (and plots) inline.
-- Works on the "# %%" scripts that jupytext.nvim produces from .ipynb files.
-- Plot images are drawn by image.nvim (Kitty graphics protocol, works in Ghostty).

-- Cell helpers: a cell starts at a "# %%" line and runs to the next one
local CELL = "^# %%"

local function cell_bounds(lnum)
  local last = vim.api.nvim_buf_line_count(0)
  local start, finish = 1, last
  for l = lnum, 1, -1 do
    if vim.fn.getline(l):match(CELL) then
      start = l
      break
    end
  end
  for l = lnum + 1, last do
    if vim.fn.getline(l):match(CELL) then
      finish = l - 1
      break
    end
  end
  return start, finish
end

-- Evaluate the code cell containing lnum (markdown cells are skipped)
local function run_cell_at(lnum)
  local start, finish = cell_bounds(lnum)
  local header = vim.fn.getline(start)
  if header:match("%[markdown%]") then
    return
  end
  if header:match(CELL) then
    start = start + 1 -- don't send the delimiter line itself
  end
  if start <= finish then
    vim.fn.MoltenEvaluateRange(start, finish)
  end
end

local function goto_cell(dir)
  local flags = dir > 0 and "W" or "bW"
  if vim.fn.search(CELL, flags) == 0 then
    vim.notify("No more cells", vim.log.levels.INFO)
  end
end

local function run_all_cells()
  local headers = {}
  for l = 1, vim.api.nvim_buf_line_count(0) do
    if vim.fn.getline(l):match(CELL) then
      table.insert(headers, l)
    end
  end
  if #headers == 0 or headers[1] > 1 then
    run_cell_at(1) -- code before the first delimiter
  end
  for _, l in ipairs(headers) do
    run_cell_at(l)
  end
end

-- Start a kernel: use the one recorded in the .ipynb metadata if it is
-- installed, otherwise let Molten prompt. Then load the saved outputs.
local function init_kernel()
  local file = vim.fn.expand("%:p")
  local kernel
  if file:match("%.ipynb$") then
    local ok, nb = pcall(function()
      return vim.json.decode(table.concat(vim.fn.readfile(file), "\n"))
    end)
    if ok and nb.metadata and nb.metadata.kernelspec then
      kernel = nb.metadata.kernelspec.name
    end
  end
  if kernel and vim.tbl_contains(vim.fn.MoltenAvailableKernels(), kernel) then
    vim.cmd("MoltenInit " .. kernel)
    if file:match("%.ipynb$") then
      vim.cmd("MoltenImportOutput")
    end
  else
    vim.cmd("MoltenInit") -- pick from the list of installed kernels
  end
end

return {
  -- https://github.com/benlubas/molten-nvim
  "benlubas/molten-nvim",
  version = "^1.0.0",
  dependencies = { "3rd/image.nvim", "GCBallesteros/jupytext.nvim" },
  build = ":UpdateRemotePlugins",
  lazy = false, -- remote (python) plugin, must be registered at startup
  init = function()
    -- Molten is a python remote plugin: it needs pynvim + jupyter_client,
    -- both installed in miniforge's base env (kernels can live anywhere)
    vim.g.python3_host_prog = vim.fn.expand("~/miniforge3/bin/python3")

    vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_auto_open_output = true -- show the output float after running
    vim.g.molten_output_win_max_height = 30
    vim.g.molten_wrap_output = true
    vim.g.molten_virt_text_output = true -- keep a text preview under the cell
    vim.g.molten_virt_lines_off_by_1 = true -- put it after the cell, not on its last line
    vim.g.molten_enter_output_behavior = "open_and_enter"

    -- Molten 1.9.2's remove_comments (used by MoltenImport/ExportOutput) reads
    -- `#offset!` metadata ranges, which nvim 0.12 no longer fills in. Replace it
    -- with one that uses the comment node ranges directly.
    package.loaded["remove_comments"] = {
      remove_comments = function(str, lang)
        local root = vim.treesitter.get_string_parser(str, lang):parse()[1]:root()
        local query = vim.treesitter.query.parse(lang, "(comment) @c")
        local lines = vim.split(str, "\n")
        for _, node in query:iter_captures(root, str) do
          local row, col = node:range()
          lines[row + 1] = string.sub(lines[row + 1], 1, col)
        end
        lines = vim.tbl_filter(function(line) return line ~= "" end, lines)
        return table.concat(lines, "\n")
      end,
    }

    -- Write kernel outputs back into the .ipynb on save (after jupytext writes it)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.ipynb",
      callback = function()
        if require("molten.status").initialized() == "Molten" then
          vim.cmd("MoltenExportOutput!")
        end
      end,
    })
  end,
  keys = {
    { "<leader>ji", init_kernel, desc = "Jupyter: start kernel (+ load outputs)" },
    { "<leader>jr", function() run_cell_at(vim.fn.line(".")) end, desc = "Jupyter: run cell" },
    {
      "<leader>jn",
      function()
        run_cell_at(vim.fn.line("."))
        goto_cell(1)
      end,
      desc = "Jupyter: run cell and go to next",
    },
    { "<leader>ja", run_all_cells, desc = "Jupyter: run all cells" },
    { "<leader>jl", "<cmd>MoltenEvaluateLine<CR>", desc = "Jupyter: run line" },
    { "<leader>jr", ":<C-u>MoltenEvaluateVisual<CR>gv<Esc>", mode = "v", desc = "Jupyter: run selection" },
    { "<leader>jo", "<cmd>noautocmd MoltenEnterOutput<CR>", desc = "Jupyter: open/enter output" },
    { "<leader>jh", "<cmd>MoltenHideOutput<CR>", desc = "Jupyter: hide output" },
    { "<leader>jd", "<cmd>MoltenDelete<CR>", desc = "Jupyter: delete cell output" },
    { "<leader>jx", "<cmd>MoltenInterrupt<CR>", desc = "Jupyter: interrupt kernel" },
    { "<leader>jR", "<cmd>MoltenRestart!<CR>", desc = "Jupyter: restart kernel" },
    { "<leader>jq", "<cmd>MoltenDeinit<CR>", desc = "Jupyter: stop kernel" },
    { "]j", function() goto_cell(1) end, desc = "Next notebook cell" },
    { "[j", function() goto_cell(-1) end, desc = "Previous notebook cell" },
  },
}
