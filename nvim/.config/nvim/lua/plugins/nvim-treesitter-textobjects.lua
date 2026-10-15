-- Syntax-aware text objects, motions and swaps (functions, classes, parameters)
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects (main branch)
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  lazy = false,
  config = function()
    require('nvim-treesitter-textobjects').setup({
      select = {
        lookahead = true, -- jump forward to the next text object, like targets.vim
        selection_modes = {
          ['@function.outer'] = 'V', -- select whole lines for functions and classes
          ['@class.outer'] = 'V',
        },
      },
      move = {
        set_jumps = true, -- add moves to the jumplist so <C-o> goes back
      },
    })

    local select = require('nvim-treesitter-textobjects.select')
    local move = require('nvim-treesitter-textobjects.move')
    local swap = require('nvim-treesitter-textobjects.swap')

    -- Select: use with operators (daf, cif, yac, ...) or in visual mode (vaf)
    local objects = {
      af = { '@function.outer', 'Around function' },
      ['if'] = { '@function.inner', 'Inside function' },
      ac = { '@class.outer', 'Around class' },
      ic = { '@class.inner', 'Inside class' },
      aa = { '@parameter.outer', 'Around parameter' },
      ia = { '@parameter.inner', 'Inside parameter' },
    }
    for lhs, obj in pairs(objects) do
      vim.keymap.set({ 'x', 'o' }, lhs, function()
        select.select_textobject(obj[1], 'textobjects')
      end, { desc = obj[2] })
    end

    -- Move: ]f/[f avoid ]c/[c (diff hunks), ]a/[a (arglist) and ]]/[[ (markdown headers)
    vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
      move.goto_next_start('@function.outer', 'textobjects')
    end, { desc = 'Next function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
      move.goto_previous_start('@function.outer', 'textobjects')
    end, { desc = 'Previous function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
      move.goto_next_end('@function.outer', 'textobjects')
    end, { desc = 'Next function end' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
      move.goto_previous_end('@function.outer', 'textobjects')
    end, { desc = 'Previous function end' })

    -- Swap: move the parameter under the cursor right/left
    vim.keymap.set('n', '<leader>a', function()
      swap.swap_next('@parameter.inner')
    end, { desc = 'Swap parameter with next' })
    vim.keymap.set('n', '<leader>A', function()
      swap.swap_previous('@parameter.inner')
    end, { desc = 'Swap parameter with previous' })
  end,
}
