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

- **Neovim** uses native `vim.pack.add()` (requires Neovim 0.10+) for plugin management. Plugins are auto-discovered via glob patterns in `nvim/.config/nvim/lua/plugins/`.
- **Color theme:** Catppuccin Macchiato/Frappe throughout.
- **Cross-platform scripts** use `case "$(uname)"` for macOS/Linux detection.
- **Vim-style navigation** (`h/j/k/l`) is consistent across Sway, i3, tmux, and Neovim.
- **tmux-vim navigation** uses `vim-tmux-navigator` for seamless `Ctrl+h/j/k/l` pane switching.
- **Development focus:** JavaScript, TypeScript, Rust (reflected in LSP and formatter configs).

## Setup Script

The `setup.sh` script automates the deployment of dotfiles with the following features:

- **OS Detection**: Detects macOS or Linux and installs platform-specific tools.
- **Backup**: Creates backups of existing dotfiles in `~/.dotfiles-backup-<timestamp>/`.
- **Dependency Checks**: Verifies that required tools (e.g., `stow`, `zsh`, `neovim`) are installed.
- **Symlink Management**: Uses `stow` to create symlinks for all packages.
- **Conflict Resolution**: Handles conflicts by backing up existing files or skipping packages.

### Usage Examples

```bash
./setup.sh                          # Interactive mode
./setup.sh --all                    # Install all packages
./setup.sh --packages "nvim tmux"   # Install specific packages
./setup.sh --dry-run                # Preview changes without installing
./setup.sh --all --yes --force      # Full auto install
```

## Keybindings

| Tool       | Keybinding       | Action                          |
|------------|------------------|---------------------------------|
| tmux       | `Ctrl+h/j/k/l`   | Navigate panes (vim-tmux-navigator) |
| Sway/i3    | `Super+h/j/k/l`  | Navigate windows                |
| Neovim     | `Ctrl+h/j/k/l`   | Navigate splits                 |

## Neovim Plugin Management

Plugins are managed using Neovim's native `vim.pack.add()`. Plugins are stored in `nvim/.config/nvim/pack/plugins/` and are auto-discovered via glob patterns in `nvim/.config/nvim/lua/plugins/`. Plugins are gitignored and downloaded at runtime using `git clone`.

Supported languages:
- **JavaScript/TypeScript**: LSP (`tsserver`), Formatter (`prettier`)
- **Rust**: LSP (`rust-analyzer`), Formatter (`rustfmt`)
- **Lua**: LSP (`lua-ls`)

## Dependencies

| Platform  | Dependencies                          |
|-----------|---------------------------------------|
| macOS     | `stow`, `zsh`, `neovim`, `tmux`, `ghostty`, `git`, `ripgrep`, `fzf` |
| Linux     | `stow`, `zsh`, `neovim`, `tmux`, `sway`, `i3`, `waybar`, `tofi`, `swaylock`, `git`, `ripgrep`, `fzf` |

## Backup Strategy

The `setup.sh` script creates backups of conflicting files in `~/.dotfiles-backup-<timestamp>/`. Backups include:
- A log file (`backup.log`) listing all backed-up files.
- The original files, preserved in their original directory structure.

To restore a backup:

```bash
mv ~/.dotfiles-backup-<timestamp>/* ~/
```

## Platform-Specific Notes

### macOS

The following tools are available on macOS:
- **Ghostty**: Terminal emulator
- **Neovim**: Text editor
- **tmux**: Terminal multiplexer
- **Zsh**: Shell

### Linux

The following tools are available on Linux (Arch):
- **Sway/i3**: Window managers
- **Waybar**: Status bar
- **Tofi**: Launcher
- **Swaylock**: Screen locker
- **Ghostty**: Terminal emulator
- **Neovim**: Text editor
- **tmux**: Terminal multiplexer
- **Zsh**: Shell

## Testing

Run the `test.sh` script to validate configurations:

```bash
./test.sh
```

This script checks for:
- Broken symlinks
- Missing dependencies
- Linting errors in shell scripts and Lua files.

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
