# AGENTS.md

## Project Overview

Personal dotfiles repository for Arch Linux and macOS. Configuration files for terminal tools, window managers, editors, and shell environments.

## Architecture

**Deployment method:** [GNU Stow](https://www.gnu.org/software/stow/) — each top-level directory is a stow package that symlinks into `$HOME`.

```
stow <package>     # creates symlinks from $HOME into the repo
stow -D <package>  # removes symlinks
stow */            # installs everything
```

**Two directory conventions:**

- XDG-style: `package/.config/tool/...` symlinks to `~/.config/tool/...`
- Home-dot style: `package/.dotfile` symlinks to `~/.dotfile`

## Packages

| Directory | Tool | Target |
|-----------|------|--------|
| `ghostty/` | Ghostty terminal | `~/.config/ghostty/` |
| `i3/` | i3 window manager (X11) | `~/.config/i3/` |
| `nvim/` | Neovim (Lua config) | `~/.config/nvim/` |
| `scripts/` | Utility shell scripts | `~/.config/scripts/` |
| `spaceship/` | Spaceship Zsh prompt | `~/.config/spaceship.zsh` |
| `sway/` | Sway compositor (Wayland) | `~/.config/sway/` |
| `swaylock/` | Swaylock screen locker | `~/.config/swaylock/` |
| `tmux/` | tmux multiplexer | `~/.tmux.conf` |
| `tofi/` | Tofi launcher (Wayland) | `~/.config/tofi/` |
| `waybar/` | Waybar status bar | `~/.config/waybar/` |
| `zsh/` | Zsh shell | `~/.zshrc` |

## Key Technical Details

- **Neovim** uses native `vim.pack.add()` (requires Neovim 0.10+), not a plugin manager. Plugins and LSP configs auto-discover files via glob patterns.
- **Color theme:** Catppuccin Macchiato/Frappe throughout (README mentions Nord but actual configs use Catppuccin).
- **Cross-platform scripts** use `case "$(uname)"` for macOS/Linux detection.
- **Vim-style navigation** (`h/j/k/l`) is consistent across Sway, i3, tmux, and Neovim.
- **tmux-vim navigation** uses `vim-tmux-navigator` for seamless `Ctrl+h/j/k/l` pane switching.
- **Development focus:** JavaScript, TypeScript, Rust (reflected in LSP and formatter configs).

## Languages

- **Lua** — Neovim configuration (`nvim/.config/nvim/`)
- **Shell/Zsh** — Scripts and shell config (`scripts/`, `zsh/`)
- **CSS/JSONC** — Waybar styling and config

## Conventions

- One tool per top-level directory, structured as a stow package.
- `nvim/.stow-local-ignore` excludes `.jpg` and `.md` from symlinking.
- Plugins/autoload dirs in nvim are gitignored (downloaded at runtime).
- `setup.sh` automates deployment with OS detection, backup, and dependency checking.

## Platform Targets

- **Arch Linux:** Full stack (Sway/i3 + Waybar + Tofi + Swaylock + terminal + Neovim + tmux + Zsh)
- **macOS:** Subset (Ghostty + Neovim + tmux + Zsh)
