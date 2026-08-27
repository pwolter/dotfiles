return {
  'gbprod/nord.nvim', -- You can replace this with your favorite colorscheme
  -- 'rebelot/kanagawa.nvim', -- You can replace this with your favorite colorscheme
  lazy = false, -- We want the colorscheme to load immediately when starting Neovim
  priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
  config = function()
      require("nord").setup({})
      vim.cmd.colorscheme("nord")
  end,
}
