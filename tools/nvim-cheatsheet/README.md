# nvim-cheatsheet

Generates a professional **Neovim keybindings** reference PDF from a curated
list of mappings. Renders HTML and prints it to PDF via headless Google Chrome.

## Usage

```sh
cd tools/nvim-cheatsheet

python3 generate.py                 # multi-page (default), 3 columns
python3 generate.py --single-page   # dense one-pager, 4 columns
python3 generate.py -o ~/nvim.pdf   # custom output path
python3 generate.py --html-only     # write the HTML only, skip the PDF
```

Default output: `~/Downloads/nvim-keybindings.pdf`.

## Keeping it in sync

The mapping list lives in the `SECTIONS` table at the top of `generate.py`
(curated by hand — categorized, with clean descriptions). When you change
your Neovim keymaps, edit that table and re-run the script.

## Requirements

- Python 3 (standard library only)
- Google Chrome or Chromium (for PDF rendering; not needed with `--html-only`)
