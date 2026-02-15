# Dotfiles

Personal configuration files for Arch Linux and macOS development environments. Managed using [GNU Stow](https://www.gnu.org/software/stow/) with a consistent Nord color theme across all tools.

## Installation

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

#### [Waybar](https://github.com/Alexays/Waybar)

Highly customizable status bar for Wayland compositors. Configured with JSONC format and styled with CSS for a clean, informative interface.

- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Configuration Examples](https://github.com/Alexays/Waybar/wiki/Examples)
- [Module Reference](https://github.com/Alexays/Waybar/wiki/Module:-Custom)

#### [i3](https://i3wm.org/)

Tiling window manager for X11. Alternative configuration for non-Wayland systems with similar keybindings to Sway.

- [i3 User's Guide](https://i3wm.org/docs/userguide.html)
- [i3 Configuration](https://i3wm.org/docs/userguide.html#configuring)
- [i3 Reference Card](https://i3wm.org/docs/refcard.html)

#### [Polybar](https://github.com/polybar/polybar)

Fast and customizable status bar for X11 window managers. Used alongside i3 for system information display.

- [Polybar Wiki](https://github.com/polybar/polybar/wiki)
- [Configuration Guide](https://github.com/polybar/polybar/wiki/Configuration)
- [Module Examples](https://github.com/polybar/polybar/wiki/Module:-date)

### Terminal

#### [Kitty](https://sw.kovidgoyal.net/kitty/)

GPU-accelerated terminal emulator with support for images, ligatures, and extensive customization.

- [Kitty Documentation](https://sw.kovidgoyal.net/kitty/)
- [Configuration Reference](https://sw.kovidgoyal.net/kitty/conf/)
- [Kitty Kittens](https://sw.kovidgoyal.net/kitty/kittens_intro/)

#### [tmux](https://github.com/tmux/tmux/wiki)

Terminal multiplexer for managing multiple terminal sessions. Configured with `C-a` prefix, vi-mode, and Nord theme.

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

Powerful shell with extensive customization. Configured with Oh My Zsh, Spaceship prompt, and vi-mode keybindings.

- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)
- [Zsh Guide](https://zsh.sourceforge.io/Guide/)
- [Oh My Zsh](https://ohmyz.sh/)

#### [Spaceship Prompt](https://spaceship-prompt.sh/)

Minimalistic, powerful prompt for Zsh with git status, language versions, and execution time display.

- [Spaceship Documentation](https://spaceship-prompt.sh/getting-started/)
- [Spaceship Options](https://spaceship-prompt.sh/options/)
- [Spaceship Sections](https://spaceship-prompt.sh/sections/)

### Utilities

#### [Picom](https://github.com/yshui/picom)

Lightweight compositor for X11 providing window transparency, shadows, and effects.

- [Picom Documentation](https://github.com/yshui/picom)
- [Configuration Guide](https://github.com/yshui/picom/blob/next/picom.sample.conf)
- [Man Page](https://man.archlinux.org/man/picom.1)

#### [Tofi](https://github.com/philj56/tofi)

Fast application launcher for Wayland with dmenu compatibility and minimal dependencies.

- [Tofi Documentation](https://github.com/philj56/tofi)
- [Configuration Reference](https://github.com/philj56/tofi/blob/master/doc/config)
- [Tofi Examples](https://github.com/philj56/tofi#usage)

#### [Swaylock](https://github.com/swaywm/swaylock)

Screen locking utility for Wayland compositors with customizable appearance.

- [Swaylock Documentation](https://github.com/swaywm/swaylock)
- [Man Page](https://man.archlinux.org/man/swaylock.1)
- [Configuration Examples](https://github.com/swaywm/swaylock#configuration)

## Platform Support

- **Arch Linux** - Primary development platform
- **macOS** - Compatible configurations where applicable

## Theme

Configurations use the [Nord color palette](https://www.nordtheme.com/) for consistent visual aesthetics across Neovim, tmux, Sway, and terminal applications.
