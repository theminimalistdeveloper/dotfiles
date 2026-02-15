# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration written entirely in Lua, using Neovim's native package manager (`vim.pack.add()`). The configuration follows a modular architecture with automatic plugin and LSP loading.

### Core Structure

The configuration is organized into five main components, loaded in order from `init.lua`:

1. **settings** - Editor behavior (tabs, search, undo, etc.)
2. **mappings** - All keybindings with `<Space>` as leader
3. **plugins/init** - Auto-loads all plugin configs from `lua/plugins/`
4. **ui** - Visual settings (colorscheme, statusline, highlights)
5. **lsp/init** - Auto-loads all LSP configs from `lua/lsp/`

### Auto-Loading Pattern

Both plugins and LSP servers use automatic loading:

- **Plugins**: `lua/plugins/init.lua` automatically requires all `*.lua` files in `lua/plugins/` except itself
- **LSP**: `lua/lsp/init.lua` automatically requires all `*.lua` files in `lua/lsp/` except itself, then enables servers listed in `lua/lsp-list.lua`

### Adding New Plugins

Create a new file in `lua/plugins/` following this pattern:

```lua
vim.pack.add({'https://github.com/author/plugin-name'})
require('plugin-name').setup({
  -- configuration here
})
```

The plugin will be automatically loaded on next Neovim start. No need to modify `init.lua` or any other file.

### Adding New LSP Servers

1. Add the server name to `lua/lsp-list.lua`
2. Create `lua/lsp/<server-name>.lua` with configuration:

```lua
vim.lsp.config['server_name'] = {
  cmd = { 'server-binary', '--stdio' },
  root_markers = { 'package.json', '.git' },
  filetypes = { 'javascript', 'typescript' },
  settings = {
    -- LSP-specific settings
  },
}
```

The LSP server will be automatically configured and enabled.

## Language Support

Primary languages: **JavaScript, TypeScript, Rust**

Also supported: CSS, JSON, YAML, TOML, Bash, Docker Compose, GraphQL, Tailwind CSS, HTML, Lua

LSP servers are managed via Mason (`lua/plugins/mason.lua`) which auto-installs servers from `lsp-list.lua`.

## Key Dependencies

- **mini.nvim** - Core functionality (completion, fuzzy finding, git, statusline, snippets, etc.)
- **nvim-treesitter** - Syntax highlighting and code understanding
- **mason.nvim** - LSP/tool installation and management
- **nvim-tree.lua** - File explorer
- **neogit** - Git interface
- **trouble.nvim** - Diagnostic/quickfix list
- **copilot.vim** - AI code completion
- **vim-tmux-navigator** - Seamless tmux/vim navigation

## Common Commands

### Plugin Management

```vim
" Update all plugins (requires manual package manager update)
" Neovim's native package manager doesn't have a built-in update command
" Plugins are managed via vim.pack.add() in individual plugin files
```

### LSP Operations

```vim
<Space>lr  - Rename symbol
<Space>ld  - Go to definition
<Space>lh  - Show hover documentation
<Space>li  - Go to implementation
<Space>le  - Show references
<Space>lf  - Format current file
<Space>ln  - Next diagnostic
<Space>lp  - Previous diagnostic
```

### File Navigation

```vim
<Space>ff  - Find files (mini.pick)
<Space>fg  - Live grep (mini.pick)
<Space>fb  - Find buffers (mini.pick)
```

### Git Operations

Neogit is configured for git operations. Keybindings defined in `lua/plugins/neogit.lua`.

### Formatting

Auto-format on save is enabled for: `.rs`, `.js`, `.jsx`, `.ts`, `.tsx` files (see `lua/lsp/init.lua`)

## Keybinding Structure

Keybindings are organized by prefix in `lua/mappings.lua`:

- `<Space>b*` - Buffer operations
- `<Space>c*` - Quickfix operations
- `<Space>l*` - LSP operations
- `<Space>w*` - Window operations
- `<Space>v*` - Neovim config file shortcuts
- `<Space>f*` - Find/search operations (defined in plugin files)

All keybindings have descriptions accessible via `mini.clue`.

## Configuration Files

When modifying core behavior, edit these files:

- `lua/settings.lua` - Editor settings (indentation, search, undo, etc.)
- `lua/mappings.lua` - Global keybindings
- `lua/ui.lua` - Visual appearance and colorscheme
- `lua/lsp-list.lua` - Enable/disable LSP servers

## Notes

- This config uses Neovim's **native package manager** via `vim.pack.add()`, not lazy.nvim or packer
- Lock files (`lazy-lock.json`, `nvim-pack-lock.json`) track plugin versions
- Fold method is set to treesitter (`foldmethod=expr`)
- Tab width is 2 spaces across all filetypes
- Line wrapping is disabled except for markdown/norg files
- Nord colorscheme with transparent background
