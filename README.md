# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level directory is a Stow *package* whose contents mirror where the
files belong under `$HOME` (e.g. `nvim/.config/nvim` → `~/.config/nvim`).

## Install on a new machine

```sh
git clone git@github.com:pwolter/dotfiles.git ~/dotfiles
brew bundle --file ~/dotfiles/Brewfile      # installs stow and the rest
cd ~/dotfiles
stow nvim zsh vim geany yabai
```

If a target already exists (e.g. a default `~/.zshrc`), move or delete it first,
then re-run `stow <package>`.

## Stow packages

| Package | Links into                               |
|---------|------------------------------------------|
| `nvim`  | `~/.config/nvim`                         |
| `zsh`   | `~/.zshrc`, `~/.zprofile`, `~/.p10k.zsh` |
| `vim`   | `~/.vimrc`                               |
| `geany` | `~/.config/geany`                        |
| `yabai` | `~/.config/yabai`                        |

## Vim plugins

Plugins are **not** committed — they are reinstallable. After `stow vim`, open
vim and run `:PluginInstall` (Vundle) to fetch them from the manifest in
`.vimrc`. The install dirs (`~/.vim/bundle`, `~/.vim/autoload`) are gitignored.

## Not Stow-managed (GUI apps)

These store settings outside `~/.config`, so they aren't symlinked:

- **`iterm2/`** — iTerm2 loads its plist directly. In iTerm2:
  *Settings → General → Settings → "Load settings from a custom folder or URL"*
  and point it at `~/dotfiles/iterm2`.
- **`dbeaver/`** — kept for reference; restore manually.

## Tools

- **`tools/nvim-cheatsheet/`** — generates a Neovim keybindings reference PDF.
  `python3 tools/nvim-cheatsheet/generate.py` (add `--single-page` for a
  one-page version). See its README for details.
