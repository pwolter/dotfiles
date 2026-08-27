-- LSP Support
return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { 'mason-org/mason.nvim' },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { 'mason-org/mason-lspconfig.nvim' },

    -- Auto-Install LSPs, linters, formatters, debuggers
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },

    -- Lua/nvim API completion & type checking when editing this config
    -- https://github.com/folke/lazydev.nvim (successor to the archived neodev.nvim)
    { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
    { 'hrsh7th/cmp-nvim-lsp'},
  },
  config = function ()
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- Install these LSPs automatically
      ensure_installed = {
        'bashls', -- requires npm to be installed
        'cssls', -- requires npm to be installed
        'html', -- requires npm to be installed
        'lua_ls',
        'jsonls', -- requires npm to be installed
        'lemminx',
        'marksman',
        'quick_lint_js',
        'yamlls', -- requires npm to be installed
        'pyright',
        'clangd',
      }
    })

    require('mason-tool-installer').setup({
      -- Install these linters, formatters, debuggers automatically
      ensure_installed = {
        'black',
        'debugpy',
        'flake8',
        'isort',
        'mypy',
        'pylint',
      },
    })
  end,
}
