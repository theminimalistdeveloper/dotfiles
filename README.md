# Dotfiles

Personal configuration files for Arch Linux and macOS development environments. Managed using [GNU Stow](https://www.gnu.org/software/stow/) with a consistent [Catppuccin](https://catppuccin.com/) color theme across all tools.

## Installation

### Automated Setup (Recommended)

Run the setup script for guided installation:

```bash
./setup.sh
```

Or install all packages automatically:

```bash
./setup.sh --all
```

**Options:**

| Flag | Description |
|------|-------------|
| `--all` | Install all platform-appropriate packages |
| `--packages "..."` | Install specific packages (space-separated) |
| `--dry-run` | Preview changes without installing |
| `--yes`, `-y` | Skip all confirmations |
| `--force` | Overwrite existing configs (auto-backup conflicts) |
| `--no-backup` | Skip backup process |
| `--help`, `-h` | Show all options |

### Manual Installation

Install configurations using GNU Stow:

```bash
# Install all packages
stow */

# Install specific package
stow nvim tmux zsh

# Remove package
stow -D nvim
```

## Tools

### Window Management

#### [Sway](https://swaywm.org/)

Tiling Wayland compositor and i3-compatible replacement for X11. Primary window manager configuration with vim-style navigation and Super key as modifier.

- [Sway Wiki](https://github.com/swaywm/sway/wiki)
- [Configuration Guide](https://man.archlinux.org/man/sway.5)
- [Getting Started](https://github.com/swaywm/sway#running)

#### [Quickshell](https://quickshell.outfoxxed.me/)

Flexible toolkit for building desktop shells with QtQuick (QML). Used for a Catppuccin-styled top bar and a macOS Spotlight-style launcher that talk to Sway over the i3 IPC protocol. Config lives in `~/.config/quickshell/topbar/` and hot-reloads on file save. `$mod+space` toggles the launcher.

- [Quickshell Website](https://quickshell.outfoxxed.me/)
- [Quickshell Documentation](https://quickshell.outfoxxed.me/docs/)
- [Quickshell Source](https://github.com/quickshell-mirror/quickshell)

### Terminal

#### [Ghostty](https://ghostty.org/)

Fast, native terminal emulator with GPU acceleration, ligatures, and platform-native UI on macOS and Linux.

- [Ghostty Documentation](https://ghostty.org/docs)
- [Configuration Reference](https://ghostty.org/docs/config)
- [Ghostty GitHub](https://github.com/ghostty-org/ghostty)

#### [tmux](https://github.com/tmux/tmux/wiki)

Terminal multiplexer for managing multiple terminal sessions. Configured with `C-a` prefix, vi-mode, and Catppuccin theme.

- [tmux Guide](https://github.com/tmux/tmux/wiki/Getting-Started)
- [tmux Configuration](https://man.openbsd.org/tmux.1#CONFIGURATION_FILES)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)

### Editor

#### [Neovim](https://neovim.io)

Hyperextensible Vim-based text editor with native LSP support. Comprehensive Lua-based configuration focused on JavaScript, TypeScript, and Rust development.

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide for Neovim](https://neovim.io/doc/user/lua-guide.html)
- [Configuration Details](./nvim/README.md) (local)

### Shell

#### [Zsh](https://www.zsh.org/)

Powerful shell with extensive customization. Configured with Oh My Zsh, Starship prompt, and vi-mode keybindings.

- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)
- [Zsh Guide](https://zsh.sourceforge.io/Guide/)
- [Oh My Zsh](https://ohmyz.sh/)

#### [Starship](https://starship.rs/)

Minimal, blazing-fast, customizable prompt with git status, language versions, and execution time display.

- [Starship Documentation](https://starship.rs/guide/)
- [Starship Configuration](https://starship.rs/config/)
- [Preset Configurations](https://starship.rs/presets/)

### Utilities

#### [Swaylock](https://github.com/swaywm/swaylock)

Screen locking utility for Wayland compositors with customizable appearance.

- [Swaylock Documentation](https://github.com/swaywm/swaylock)
- [Man Page](https://man.archlinux.org/man/swaylock.1)
- [Configuration Examples](https://github.com/swaywm/swaylock#configuration)

## Platform Support

- **Arch Linux** - Primary development platform
- **macOS** - Compatible configurations where applicable

## Theme

Configurations use the [Catppuccin](https://catppuccin.com/) color palette (Macchiato/Frappe variants) for consistent visual aesthetics across Neovim, tmux, Sway, Ghostty, and terminal applications.
