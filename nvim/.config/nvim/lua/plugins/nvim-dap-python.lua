return {
  -- https://github.com/mfussenegger/nvim-dap-python
  'mfussenegger/nvim-dap-python',
  ft = 'python',
  dependencies = {
    -- https://github.com/mfussenegger/nvim-dap
    'mfussenegger/nvim-dap',
  },
  config = function()
    -- Point the debug adapter at the first Python that exists (needs debugpy).
    -- Portable across machines: prefers a conda base under $HOME, else python3.
    local function debugpy_python()
      for _, p in ipairs({
        '~/miniforge3/bin/python',
        '~/miniconda3/bin/python',
        '~/anaconda3/bin/python',
      }) do
        local x = vim.fn.expand(p)
        if vim.fn.executable(x) == 1 then return x end
      end
      return 'python3'
    end
    require('dap-python').setup(debugpy_python())
  end
}
