#!/usr/bin/env python3
"""
Generate a professional Neovim keybindings reference PDF.

Usage:
    python3 generate.py                 # multi-page (default), 3 columns
    python3 generate.py --single-page   # dense one-pager, 4 columns
    python3 generate.py -o out.pdf      # custom output path
    python3 generate.py --html-only     # write the HTML, skip the PDF

Renders HTML and prints it to PDF with headless Google Chrome (macOS).
The keymap data below is curated by hand — update SECTIONS when the
Neovim keymaps change, then re-run this script.
"""
import argparse
import html
import os
import shutil
import subprocess
import sys
import tempfile

# ---------------------------------------------------------------------------
# Keymap data — (Section title, [(key, mode|None, action), ...])
# Mode is None for Normal mode; otherwise a short string like "i" or "n v i".
# ---------------------------------------------------------------------------
SECTIONS = [
    ("General / Write", [
        ("<Space>", None, "Leader key (no-op)"),
        ("<leader>ww", None, "Save"),
        ("<leader>wq", None, "Save and quit"),
        ("<leader>ws", None, "Make split window width smaller"),
        ("gx", None, "Open URL under cursor"),
        ("<leader>?", None, "Show buffer-local keymaps (which-key)"),
    ]),
    ("Split / Window", [
        ("<leader>sv", None, "Split window vertically"),
        ("<leader>sh", None, "Split window horizontally"),
        ("<leader>se", None, "Make split windows equal width"),
        ("<leader>sx", None, "Close split window"),
        ("<leader>sj", None, "Make split height shorter"),
        ("<leader>sk", None, "Make split height taller"),
        ("<leader>sl", None, "Make split width bigger"),
        ("<leader>sz", None, "Toggle maximize window (zoom)"),
        ("<leader>sml", None, "Move to right split"),
        ("<leader>smh", None, "Move to left split"),
        ("<leader>smj", None, "Move to down split"),
        ("<leader>smk", None, "Move to up split"),
    ]),
    ("Tabs", [
        ("<leader>to", None, "Open new tab"),
        ("<leader>tx", None, "Close tab"),
        ("<leader>tn", None, "Next tab"),
        ("<leader>tp", None, "Previous tab"),
        ("<leader>td", None, "Toggle diagnostics on/off"),
    ]),
    ("Diff / Merge", [
        ("<leader>cc", None, "Put diff current → other"),
        ("<leader>cj", None, "Get diff from left (local)"),
        ("<leader>ck", None, "Get diff from right (remote)"),
        ("<leader>cn", None, "Next diff hunk"),
        ("<leader>cp", None, "Previous diff hunk"),
    ]),
    ("Quit / Quickfix", [
        ("<leader>qq", None, "Quit without saving"),
        ("<leader>qo", None, "Open quickfix list"),
        ("<leader>qf", None, "First quickfix item"),
        ("<leader>qn", None, "Next quickfix item"),
        ("<leader>qp", None, "Previous quickfix item"),
        ("<leader>ql", None, "Last quickfix item"),
        ("<leader>qc", None, "Close quickfix list"),
    ]),
    ("Explorer (nvim-tree)", [
        ("<leader>ee", None, "Toggle file explorer"),
        ("<leader>er", None, "Focus file explorer"),
        ("<leader>ef", None, "Find current file in explorer"),
    ]),
    ("Find (Telescope)", [
        ("<leader>ff", None, "Find files in cwd"),
        ("<leader>fg", None, "Live grep in cwd"),
        ("<leader>fb", None, "List open buffers"),
        ("<leader>fh", None, "List help tags"),
        ("<leader>fs", None, "Fuzzy find in current buffer"),
        ("<leader>fo", None, "LSP document symbols"),
        ("<leader>fi", None, "LSP incoming calls"),
        ("<leader>fm", None, "List methods (treesitter)"),
        ("<leader>ft", None, "Find TODOs"),
        ("<leader>fl", None, "List buffers (MRU, ivy theme)"),
    ]),
    ("LSP / Goto / Git", [
        ("<leader>gg", None, "Hover information"),
        ("<leader>gd", None, "Go to definition"),
        ("<leader>gD", None, "Go to declaration"),
        ("<leader>gi", None, "List implementations"),
        ("<leader>gt", None, "Go to type definition"),
        ("<leader>gr", None, "List references"),
        ("<leader>gs", None, "Signature help"),
        ("<leader>gf", None, "Format buffer"),
        ("<leader>ga", None, "Code action"),
        ("<leader>gl", None, "Show diagnostics (float)"),
        ("<leader>gp", None, "Previous diagnostic"),
        ("<leader>gn", None, "Next diagnostic"),
        ("<leader>gb", None, "Toggle git blame"),
        ("<leader>rr", None, "Rename all references"),
    ]),
    ("Harpoon", [
        ("<leader>ha", None, "Add file to Harpoon"),
        ("<leader>hh", None, "Toggle quick menu"),
        ("<leader>h1 … h9", None, "Jump to Harpoon file 1–9"),
    ]),
    ("Debug (DAP)", [
        ("<leader>bb", None, "Toggle breakpoint"),
        ("<leader>bc", None, "Set breakpoint condition"),
        ("<leader>bl", None, "Set log-point message"),
        ("<leader>br", None, "Clear breakpoints"),
        ("<leader>ba", None, "List all breakpoints"),
        ("<leader>dc", None, "Continue"),
        ("<leader>dj", None, "Step over"),
        ("<leader>dk", None, "Step into"),
        ("<leader>do", None, "Step out"),
        ("<leader>dd", None, "Disconnect"),
        ("<leader>dt", None, "Terminate"),
        ("<leader>dr", None, "Toggle REPL"),
        ("<leader>dl", None, "Run last"),
        ("<leader>di", None, "Widget hover"),
        ("<leader>d?", None, "Center floating widget (scopes)"),
        ("<leader>df", None, "Telescope DAP frames"),
        ("<leader>dh", None, "Telescope DAP commands"),
        ("<leader>de", None, "Telescope diagnostics"),
    ]),
    ("Markdown", [
        ("<leader>mre", None, "Render enable"),
        ("<leader>mrd", None, "Render disable"),
        ("<leader>mrt", None, "Render toggle"),
        ("<leader>mse", None, "Spell language English"),
        ("<leader>mss", None, "Spell language Spanish"),
        ("<leader>msb", None, "Spell English + Spanish"),
    ]),
    ("Obsidian", [
        ("<leader>oo", None, "Open note in Obsidian"),
        ("<leader>on", None, "New note"),
        ("<leader>os", None, "Quick switch / create note"),
        ("<leader>olv", None, "Follow link (vsplit)"),
        ("<leader>olh", None, "Follow link (hsplit)"),
        ("<leader>ot", None, "Insert template"),
        ("<leader>oi", None, "Paste image from clipboard"),
        ("<leader>oc", None, "Toggle checkbox"),
        ("<leader>of", None, "Search / create notes"),
    ]),
    ("Images", [
        ("<C-a>", "n v i", "Paste image from clipboard (+save)"),
        ("<leader>v", "n", "Paste image (img-clip)"),
        ("<leader>io", "n", "(macOS) Open image in Preview"),
        ("<leader>if", "n", "(macOS) Reveal image in Finder"),
        ("<leader>id", "n", "(macOS) Delete image file (trash)"),
    ]),
    ("REST / TODO", [
        ("<leader>xr", None, "Run REST query (vim-rest-console)"),
        ("]t", None, "Next TODO comment"),
        ("[t", None, "Previous TODO comment"),
    ]),
    ("Completion — insert mode", [
        ("<C-Space>", "i", "Trigger completion"),
        ("<C-j>", "i", "Next suggestion"),
        ("<C-k>", "i", "Previous suggestion"),
        ("<C-b>", "i", "Scroll docs backward"),
        ("<C-f>", "i", "Scroll docs forward"),
        ("<CR>", "i", "Confirm completion"),
        ("<Tab>", "i", "Next item / expand snippet"),
        ("<S-Tab>", "i", "Previous item"),
    ]),
]


def esc(s):
    return html.escape(s)


def build_html(single_page: bool) -> str:
    # Density knobs: (page_margin, body_font, columns, col_gap, card_mb,
    #                 h2_pad, td_pad, kbd_font, line_height)
    if single_page:
        d = dict(page_margin="8mm 8mm", body_font="7px", columns=4, col_gap="9px",
                 card_mb="7px", h2_pad="3px 6px", td_pad="1.5px 6px",
                 kbd_font="6.5px", line_height="1.25", title_size="16px")
    else:
        d = dict(page_margin="14mm 12mm", body_font="10px", columns=3, col_gap="14px",
                 card_mb="12px", h2_pad="5px 9px", td_pad="3px 9px",
                 kbd_font="8.5px", line_height="1.4", title_size="20px")

    rows_total = sum(len(rows) for _, rows in SECTIONS)

    cards = []
    for title, rows in SECTIONS:
        row_html = []
        for key, mode, action in rows:
            badge = f'<span class="mode">{esc(mode)}</span>' if mode else ''
            row_html.append(
                f'<tr><td class="k"><kbd>{esc(key)}</kbd>{badge}</td>'
                f'<td class="a">{esc(action)}</td></tr>'
            )
        cards.append(
            f'<section class="card"><h2>{esc(title)}'
            f'<span class="count">{len(rows)}</span></h2>'
            f'<table>{"".join(row_html)}</table></section>'
        )

    return f'''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Neovim Keybindings</title>
<style>
  @page {{ size: Letter; margin: {d["page_margin"]}; }}
  * {{ box-sizing: border-box; }}
  html {{ -webkit-print-color-adjust: exact; print-color-adjust: exact; }}
  body {{
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    color: #23262b; margin: 0; background: #fff;
    font-size: {d["body_font"]}; line-height: {d["line_height"]};
  }}
  header.title {{ margin-bottom: 14px; padding-bottom: 8px; border-bottom: 1.5px solid #23262b; }}
  header.title h1 {{ margin: 0; font-size: {d["title_size"]}; font-weight: 600; letter-spacing: .2px; }}
  header.title p {{ margin: 3px 0 0; color: #6b7280; font-size: .95em; }}
  header.title code {{
    font-family: ui-monospace, "SF Mono", Menlo, monospace;
    background: #f1f2f4; padding: 1px 5px; border-radius: 3px; color: #23262b;
  }}
  .grid {{ column-count: {d["columns"]}; column-gap: {d["col_gap"]}; }}
  .card {{
    break-inside: avoid; margin: 0 0 {d["card_mb"]}; border: 1px solid #d9dce1;
    border-radius: 4px; overflow: hidden;
  }}
  .card h2 {{
    margin: 0; font-size: 1.05em; font-weight: 600; letter-spacing: .3px;
    text-transform: uppercase; color: #f4f5f7; background: #3a4048;
    padding: {d["h2_pad"]}; display: flex; align-items: center; border-bottom: 2px solid #23262b;
  }}
  .card h2 .count {{ margin-left: auto; font-weight: 500; font-size: .85em; color: #cbd0d6; letter-spacing: 0; }}
  table {{ width: 100%; border-collapse: collapse; }}
  td {{ padding: {d["td_pad"]}; vertical-align: top; }}
  tr:nth-child(even) {{ background: #f7f8f9; }}
  td.k {{ white-space: nowrap; width: 1%; }}
  td.a {{ color: #3f434a; }}
  kbd {{
    font-family: ui-monospace, "SF Mono", Menlo, monospace; font-size: {d["kbd_font"]};
    background: #fff; border: 1px solid #c3c8cf; border-bottom-width: 2px;
    border-radius: 3px; padding: 1px 5px; color: #23262b; white-space: nowrap;
  }}
  .mode {{
    display: inline-block; margin-left: 5px; font-size: .8em; font-weight: 600;
    letter-spacing: .4px; text-transform: uppercase; color: #6b7280;
    border: 1px solid #d0d4da; padding: 0 4px; border-radius: 3px; vertical-align: middle;
  }}
  footer {{
    margin-top: 8px; text-align: center; color: #9aa0a8; font-size: .8em;
    border-top: 1px solid #e2e4e8; padding-top: 6px;
  }}
</style>
</head>
<body>
  <header class="title">
    <h1>Neovim Keybindings</h1>
    <p>Leader key is <code>Space</code> &nbsp;·&nbsp; {rows_total} mappings, {len(SECTIONS)} groups &nbsp;·&nbsp; Normal mode unless a badge notes otherwise (n / v / i)</p>
  </header>
  <div class="grid">{"".join(cards)}</div>
  <footer>Generated from ~/.config/nvim &nbsp;·&nbsp; pwolter/dotfiles</footer>
</body>
</html>'''


def find_chrome():
    candidates = [
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        "/Applications/Chromium.app/Contents/MacOS/Chromium",
    ]
    for c in candidates:
        if os.path.exists(c):
            return c
    for name in ("google-chrome", "chromium", "chromium-browser"):
        p = shutil.which(name)
        if p:
            return p
    return None


def main():
    ap = argparse.ArgumentParser(description="Generate the Neovim keybindings PDF.")
    ap.add_argument("--single-page", action="store_true",
                    help="dense one-page layout (4 columns). Omit for the multi-page default.")
    ap.add_argument("-o", "--output",
                    default=os.path.expanduser("~/Downloads/nvim-keybindings.pdf"),
                    help="output PDF path (default: ~/Downloads/nvim-keybindings.pdf)")
    ap.add_argument("--html-only", action="store_true",
                    help="write the HTML next to the output and skip PDF rendering")
    args = ap.parse_args()

    html_doc = build_html(args.single_page)
    n = sum(len(r) for _, r in SECTIONS)
    mode = "single-page" if args.single_page else "multi-page"

    if args.html_only:
        html_path = os.path.splitext(args.output)[0] + ".html"
        with open(html_path, "w") as f:
            f.write(html_doc)
        print(f"Wrote HTML ({mode}, {n} mappings): {html_path}")
        return

    chrome = find_chrome()
    if not chrome:
        sys.exit("Google Chrome / Chromium not found — install it or use --html-only.")

    with tempfile.NamedTemporaryFile("w", suffix=".html", delete=False) as tmp:
        tmp.write(html_doc)
        html_path = tmp.name

    try:
        subprocess.run(
            [chrome, "--headless=new", "--disable-gpu", "--no-pdf-header-footer",
             f"--print-to-pdf={args.output}", f"file://{html_path}"],
            check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
        )
    finally:
        os.unlink(html_path)

    print(f"Wrote PDF ({mode}, {n} mappings): {args.output}")


if __name__ == "__main__":
    main()
