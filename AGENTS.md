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
| `environment.d/` | Systemd user env (GTK dead-key/compose fix: `GTK_IM_MODULE=simple`) | `~/.config/environment.d/` |
| `ghostty/` | Ghostty terminal | `~/.config/ghostty/` |
| `nvim/` | Neovim (Lua config) | `~/.config/nvim/` |
| `opencode/` | OpenCode (global config + CLI theme) | `~/.config/opencode/` |
| `quickshell/` | Quickshell top bar + launcher (QML) | `~/.config/quickshell/topbar/` |
| `scripts/` | Utility shell scripts | `~/.config/scripts/` |
| `sway/` | Sway compositor (Wayland) | `~/.config/sway/` |
| `swaylock/` | Swaylock screen locker | `~/.config/swaylock/` |
| `tmux/` | tmux multiplexer | `~/.tmux.conf` |
| `zsh/` | Zsh shell | `~/.zshrc` |

## Key Technical Details

- **Neovim** uses native `vim.pack.add()` (requires Neovim 0.10+) for plugin management. Plugins are auto-discovered via glob patterns in `nvim/.config/nvim/lua/plugins/`.
- **Color theme:** Catppuccin Macchiato/Frappe throughout.
- **Cross-platform scripts** use `case "$(uname)"` for macOS/Linux detection.
- **Vim-style navigation** (`h/j/k/l`) is consistent across Sway, tmux, and Neovim.
- **tmux-vim navigation** uses `vim-tmux-navigator` for seamless `Ctrl+h/j/k/l` pane switching.
- **Development focus:** JavaScript, TypeScript, Rust (reflected in LSP and formatter configs).
- **OpenCode** global config and CLI theme are synced. Machine-specific files in `~/.config/opencode/` are intentionally **not** tracked: `agent/*.md` (symlinks to a local nubes-agents path), `plugins/herdr-agent-state.js` (herdr-managed), `node_modules/`/`bun.lock`/`package*.json`, `tools/`, and `service.json` (holds auth credentials).
- **Quickshell** runs the top bar AND a macOS-Spotlight-style launcher together in one process (`quickshell -c topbar`). It talks to Sway via `Quickshell.I3` IPC, exposes an `IpcHandler` target (`topbar`) so `$mod+space` can toggle the launcher with `quickshell ipc -c topbar call topbar toggleLauncher`, and hot-reloads on file save.

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
| Sway       | `Super+h/j/k/l`  | Navigate windows                |
| Sway       | `Super+space`    | Toggle launcher (Quickshell)    |
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
| Linux     | `stow`, `zsh`, `neovim`, `tmux`, `ghostty`, `sway`, `quickshell`, `swaylock`, `git`, `ripgrep`, `fzf`, `iw`, `brightnessctl`, `grim`, `wireplumber`, `networkmanager` |

### Additional (pending approval)

The following packages are NOT required by the dotfiles and are never installed automatically. They are heavyweight NVIDIA/AI tooling plus optional tools this workstation also uses; `setup.sh` presents them in an "additional packages (pending approval)" step that must be explicitly approved before they are recommended.

- **NVIDIA stack**: `nvidia-open`, `nvidia-utils`, `lib32-nvidia-utils`, `opencl-nvidia`, `vulkan-icd-loader`, `lib32-vulkan-icd-loader`, `linux-firmware-nvidia`, `libnvidia-container`, `nvidia-container-toolkit`
- **AI / ML**: `cuda`, `ollama`, `llama-cpp`, `whisper-cpp`, `python-pytorch-cuda`
- **Optional tools**: `rclone`, `brave`

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
- **Sway**: Window manager (Wayland)
- **Quickshell**: Top bar + launcher
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
- **QML** — Quickshell top bar (`quickshell/.config/quickshell/`)

## Conventions

- One tool per top-level directory, structured as a stow package.
- `nvim/.stow-local-ignore` excludes `.jpg` and `.md` from symlinking.
- Plugins/autoload dirs in nvim are gitignored (downloaded at runtime).
- `setup.sh` automates deployment with OS detection, backup, and dependency checking.

## Platform Targets

- **Arch Linux:** Full stack (Sway + Quickshell (top bar + launcher) + Swaylock + terminal + Neovim + tmux + Zsh)
- **macOS:** Subset (Ghostty + Neovim + tmux + Zsh)
