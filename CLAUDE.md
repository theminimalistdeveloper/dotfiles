# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a GNU Stow-based dotfiles repository managing configurations for Arch Linux and macOS environments. The repository uses a modular structure where each top-level directory represents a "package" that mirrors the home directory structure.

## Architecture

### GNU Stow Structure

Each top-level directory (e.g., `nvim/`, `tmux/`, `sway/`) is a stow package containing files that mirror their target locations:

- Files at package root (e.g., `tmux/.tmux.conf`) → deployed to `~/`
- Files in `.config/` subdirectories (e.g., `nvim/.config/nvim/`) → deployed to `~/.config/`
- The `.stow-local-ignore` file in packages excludes files from being stowed (e.g., README.md, screenshots)

### Key Configurations

**Window Management:**
- **sway** - Primary Wayland compositor (Mod4/Super key, vim-style navigation)
- **waybar** - Status bar for Sway (config in `.config/waybar/config.jsonc`)
- **i3** - Alternative X11 window manager
- **polybar** - Status bar for i3

**Terminal Environment:**
- **zsh** - Shell configuration using Oh My Zsh with Spaceship theme, vi bindings
- **tmux** - Terminal multiplexer (prefix: C-a, vi mode, Nord theme)
- **kitty** - Terminal emulator

**Editor:**
- **nvim** - Comprehensive Neovim configuration (see `nvim/CLAUDE.md` for details)
  - Native package manager (`vim.pack.add()`)
  - Auto-loading plugin/LSP architecture
  - Focused on JavaScript, TypeScript, and Rust development

**Other:**
- **picom** - X11 compositor
- **tofi** - Application launcher
- **swaylock** - Screen locker
- **gtk-3.0** - GTK theme settings
- **backgrounds** - Wallpapers
- **scripts** - Utility scripts (i3lock, polybar launcher)

### Theme Consistency

The configuration uses the **Nord color palette** across multiple components:
- Neovim (Nord colorscheme with transparent background)
- tmux status line
- Sway/i3 window borders and UI elements

## Deployment

### Installing Dotfiles

Use GNU Stow to symlink configurations to the home directory:

```bash
# Install all packages
stow */

# Install specific package
stow nvim

# Install multiple packages
stow nvim tmux zsh

# Remove/uninstall package
stow -D nvim
```

Stow creates symlinks from the package directories to their target locations in `$HOME`.

### Prerequisites

**Common:**
- GNU Stow
- Nerd Font (e.g., JetBrains Mono Nerd Font, Gohufont)
- ripgrep (for zsh FZF integration and nvim grep)
- eza (modern ls replacement, aliased in zsh)
- fd (file finder, used in zsh aliases)

**Window Management:**
- Sway or i3
- Waybar or Polybar
- Kitty or compatible terminal

**Development:**
- Neovim 0.10+
- Node.js (for LSP servers)
- Rust (for Rust development)
- tmux

## Zsh Configuration

The zsh setup sources multiple files from the `zsh/` directory:

- **`.zshrc`** - Main configuration (exports, Oh My Zsh setup)
- **`aliases.zsh`** - Command aliases (tmux shortcuts, nvim as `n`, eza as `ls`)
- **`nvm.zsh`** - Node Version Manager integration
- **`~/api-keys.zsh`** - External file for API keys (not in repo)

**Key settings:**
- Theme: Spaceship
- Editor: Neovim
- Vi mode enabled (`bindkey -v`)
- FZF default command uses ripgrep
- Plugins: aws, git, tmux

**Common aliases:**
- `n` - nvim
- `tn` - tmux new session
- `ta` - tmux attach
- `cdc` - fzf-based navigation to code directory

## Tmux Configuration

Located in `tmux/.tmux.conf`:

- Prefix: `C-a` (not default `C-b`)
- Vi mode for copy and navigation
- Nord theme for status line
- Base index starts at 1
- 10,000 line history
- Integration with Neovim (vim-tmux-navigator)

## Sway Configuration

Located in `sway/.config/sway/config`:

- Mod key: Mod4 (Super/Windows key)
- Vim-style navigation (hjkl)
- Auto-starts: waybar, ghostty, brave, swaybg
- Smart borders and gaps enabled

## Neovim Configuration

See `nvim/CLAUDE.md` for comprehensive documentation on:
- Plugin management (native package manager)
- LSP server configuration
- Auto-loading architecture
- Keybindings and workflows
- Language support (JS/TS/Rust primary)

## Modifying Configurations

### Adding a New Stow Package

1. Create directory with appropriate structure mirroring home directory
2. Add configuration files
3. Optionally create `.stow-local-ignore` to exclude documentation
4. Run `stow <package-name>` to deploy

### Updating Existing Configurations

Edit files directly in their package directories - changes are immediately reflected via symlinks (or restart the application to reload configuration).

### Testing Changes

After modifying configurations:
- **Sway:** `swaymsg reload`
- **i3:** `i3-msg reload`
- **tmux:** `tmux source-file ~/.tmux.conf` or `prefix + r` if bound
- **Zsh:** `source ~/.zshrc`
- **Neovim:** Restart Neovim

## Repository Maintenance

The `.gitignore` excludes Neovim plugin directories and autoload files to keep the repository clean. Plugin installation is handled by Neovim's native package manager on first launch.

When adding new files to packages with `.stow-local-ignore`, ensure documentation files (README.md, screenshots) match the ignore patterns to prevent them from being stowed to the home directory.
