-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter (main branch)
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- old clones stay on the archived master branch otherwise
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  lazy = false, -- main branch does not support lazy-loading
  config = function()
    local ts = require('nvim-treesitter')

    -- Parsers to always have; latex is needed for math rendering in markdown
    ts.install({
      'lua', 'python', 'c', 'cpp', 'bash', 'json', 'yaml', 'toml',
      'markdown', 'markdown_inline', 'latex', 'regex', 'vim', 'vimdoc',
    })

    -- main branch does not enable anything by default: start highlighting and
    -- indentation per buffer, and install missing parsers on first use
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        if vim.list_contains(ts.get_available(), lang) and not vim.list_contains(ts.get_installed(), lang) then
          ts.install(lang)
        end
        if pcall(vim.treesitter.start, args.buf, lang) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
