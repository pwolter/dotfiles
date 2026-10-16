-- Open/edit/save .ipynb files as plain scripts via the jupytext CLI
return {
  "GCBallesteros/jupytext.nvim",
  lazy = false, -- must load before a .ipynb buffer is read
  opts = {
    style = "percent", -- cells delimited by "# %%" (works with most tooling)
    output_extension = "auto",
    force_ft = nil,
  },
}
