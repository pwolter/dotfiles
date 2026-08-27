-- Fuzzy finder
return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { 'nvim-lua/plenary.nvim' },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-tree/nvim-web-devicons' },
    { 'folke/todo-comments.nvim' },
  },
--  opts = {
--    defaults = {
--      layout_config = {
--        vertical = {
--          width = 0.75
--        }
--      },
--      path_display = {
--        filename_first = {
--          reverse_directories = true
--        }
--      },
--      mappings = {
--        n = {
--          ["d"] = require("telescope.actions").delete_buffer,
--          ["q"] = require("telescope.actions").close,
--        },
--      },
--    }
--  }
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        layout_config = {
          vertical = { width = 0.75 }
        },
        path_display = {
          filename_first = { reverse_directories = true }
        },
        mappings = {
          n = {
            ["d"] = actions.delete_buffer,
            ["q"] = actions.close,
          },
        },
      }
    })
  end
}
