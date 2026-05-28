# Neovim Configuration

[Neovim](https://neovim.io) - A modern, highly extensible Vim fork with native LSP support, Lua scripting, and asynchronous plugins.

> "Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie). It is not a rewrite but a continuation and extension of Vim. Many clones and derivatives exist, some very clever—but none are Vim. Neovim is built for users who want the good parts of Vim, and more."

## Overview

- Modern Neovim configuration focused on **JavaScript, TypeScript, and Rust** development
- Minimal, modular architecture with automatic plugin loading
- Built on Neovim's native LSP and package manager
- **Not** compatible with Vim
- Requires **Neovim 0.12+** for native package management

## Configuration Structure

The configuration follows a modular architecture written entirely in Lua:

```
.config/nvim/
├── init.lua           # Entry point
├── lua/
│   ├── settings.lua   # Editor settings (tabs, search, undo, etc.)
│   ├── mappings.lua   # Keybindings (<Space> as leader)
│   ├── ui.lua         # Visual settings (colorscheme, statusline)
│   ├── signs.lua      # UI signs configuration
│   ├── lsp-list.lua   # Enabled LSP servers
│   ├── plugins/
│   │   ├── init.lua   # Auto-loads all plugin configs
│   │   ├── mini-*.lua # Mini.nvim modules
│   │   ├── nvim-tree.lua
│   │   ├── neogit.lua
│   │   └── ...        # One file per plugin
│   └── lsp/
│       ├── init.lua   # Auto-loads all LSP configs
│       ├── vtsls.lua  # TypeScript/JavaScript
│       ├── rust-analyzer.lua
│       └── ...        # One file per LSP server
```

### Key Files

- **[init.lua](.config/nvim/init.lua)** - Loads configuration modules in order
- **[settings.lua](.config/nvim/lua/settings.lua)** - Editor behavior and preferences
- **[mappings.lua](.config/nvim/lua/mappings.lua)** - All custom keybindings
- **[ui.lua](.config/nvim/lua/ui.lua)** - Visual appearance (Catppuccin theme)
- **[lsp/init.lua](.config/nvim/lua/lsp/init.lua)** - LSP configuration and auto-formatting
- **[plugins/init.lua](.config/nvim/lua/plugins/init.lua)** - Plugin auto-loader

## Plugin Management

This configuration uses **Neovim's native package manager** via `vim.pack.add()`. No external plugin manager required.

### Adding a New Plugin

1. Create a new file in `.config/nvim/lua/plugins/<plugin-name>.lua`
2. Add the plugin configuration:

```lua
vim.pack.add({'https://github.com/author/plugin-name'})
require('plugin-name').setup({
  -- your configuration
})
```

3. Restart Neovim - the plugin will be automatically loaded

## Language Server Setup

LSP servers are managed through [Mason](https://github.com/williamboman/mason.nvim) and configured individually.

### Supported Languages

- **JavaScript/TypeScript** - vtsls
- **Rust** - rust-analyzer
- **Lua** - lua_ls
- **CSS** - cssls
- **JSON** - jsonls (with schemastore support)
- **YAML** - yamlls
- **TOML** - taplo
- **Bash** - bashls
- **Docker Compose** - docker_compose_language_service
- **GraphQL** - graphql
- **TailwindCSS** - tailwindcss
- **HTML** - html
- **Biome** - biome (formatter/linter)

### Adding a New LSP Server

1. Add server name to `.config/nvim/lua/lsp-list.lua`
2. Create `.config/nvim/lua/lsp/<server-name>.lua`:

```lua
vim.lsp.config['server_name'] = {
  cmd = { 'server-binary', '--stdio' },
  root_markers = { 'package.json', '.git' },
  filetypes = { 'javascript', 'typescript' },
  settings = { },
}
```

3. Mason will auto-install the server on next Neovim start

## Key Features

### Core Plugins

Plugins live in [`.config/nvim/lua/plugins/`](.config/nvim/lua/plugins) — one file per plugin, auto-loaded on startup.

#### UI & Theme

- **[catppuccin/nvim](https://github.com/catppuccin/nvim)** — Catppuccin colorscheme (Macchiato/Frappe).
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** — Fast, configurable statusline.
- **[codecompanion-lualine.nvim](https://github.com/franco-ruggeri/codecompanion-lualine.nvim)** — Lualine component showing CodeCompanion status.
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** — File explorer sidebar.
- **[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)** — Filetype icons (Nerd Font).
- **[mini.indentscope](https://github.com/nvim-mini/mini.indentscope)** — Animated indent scope guides.
- **[markview.nvim](https://github.com/OXY2DEV/markview.nvim)** — In-buffer Markdown rendering.
- **[image.nvim](https://github.com/3rd/image.nvim)** — Render images directly in the terminal buffer.
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** — Popup with available keybindings as you type.
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim)** — Lightweight LSP progress notifications.

#### Editing

- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** — Tree-sitter–powered syntax highlighting and parsing.
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** — Auto-insert matching brackets/quotes.
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** — Add/change/delete surrounding pairs (`ys`, `cs`, `ds`).
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** — Treesitter-aware commenting (`gc`, `gb`).
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** — Snippet engine.
- **[friendly-snippets](https://github.com/rafamadriz/friendly-snippets)** — Community snippet collection for LuaSnip.

#### Completion

- **[blink.cmp](https://github.com/saghen/blink.cmp)** — Fast, modern autocompletion engine.
- **[blink.lib](https://github.com/saghen/blink.lib)** — Shared library used by blink.cmp.

#### LSP, Formatting & Tooling

- **[mason.nvim](https://github.com/williamboman/mason.nvim)** — Install/manage LSP servers, linters, formatters and DAP adapters.
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** — Pluggable formatter runner (Prettier, rustfmt, etc.).
- **[schemastore.nvim](https://github.com/b0o/schemastore.nvim)** — JSON/YAML schema catalog for `jsonls`/`yamlls`.
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** — Pretty diagnostics, references and quickfix list.
- **[rustaceanvim](https://github.com/mrcjkb/rustaceanvim)** — Batteries-included Rust development (rust-analyzer wrapper).

#### Git

- **[neogit](https://github.com/NeogitOrg/neogit)** — Magit-inspired Git interface.
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** — Side-by-side diff and merge tool.
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** — Git change indicators in the sign column with hunk actions.

#### Fuzzy Finding & Notes

- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** — Fuzzy finder for files, grep, buffers, LSP, etc.
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** — Lua utility library (Telescope/Neotest/CodeCompanion dependency).
- **[popup.nvim](https://github.com/nvim-lua/popup.nvim)** — Popup API shim used by Telescope.
- **[telekasten.nvim](https://github.com/nvim-telekasten/telekasten.nvim)** — Zettelkasten-style Markdown note management.
- **[calendar-vim](https://github.com/nvim-telekasten/calendar-vim)** — Calendar UI used by Telekasten daily notes.

#### Testing & Debugging

- **[neotest](https://github.com/nvim-neotest/neotest)** — Extensible test runner UI.
- **[neotest-jest](https://github.com/nvim-neotest/neotest-jest)** — Jest adapter for neotest.
- **[neotest-rust](https://github.com/rouge8/neotest-rust)** — Rust/cargo adapter for neotest.
- **[FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim)** — Fixes `CursorHold` events (neotest dependency).
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** — Debug Adapter Protocol client.
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** — UI panels for nvim-dap.
- **[nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)** — Inline variable values during debugging.
- **[nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js)** — JavaScript/TypeScript DAP adapter.
- **[vscode-js-debug](https://github.com/microsoft/vscode-js-debug)** — Underlying JS debugger backend.
- **[nvim-nio](https://github.com/nvim-neotest/nvim-nio)** — Async I/O library used by neotest and dap-ui.

#### AI & Navigation

- **[codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)** — In-editor AI chat, inline edits and agents.
- **[codecompanion-history.nvim](https://github.com/ravitemer/codecompanion-history.nvim)** — Persistent chat history for CodeCompanion.
- **[codecompanion-spinner.nvim](https://github.com/franco-ruggeri/codecompanion-spinner.nvim)** — Spinner UI while CodeCompanion is working.
- **[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)** — Seamless `Ctrl+h/j/k/l` navigation across vim splits and tmux panes.

### Keybindings

Leader key: `<Space>`

**File Navigation:**
- `<Space>ff` - Find files
- `<Space>fg` - Live grep
- `<Space>fb` - Find buffers

**LSP:**
- `<Space>lr` - Rename symbol
- `<Space>ld` - Go to definition
- `<Space>lh` - Hover documentation
- `<Space>li` - Go to implementation
- `<Space>le` - Show references
- `<Space>lf` - Format file
- `<Space>ln` - Next diagnostic
- `<Space>lp` - Previous diagnostic

**Buffers:**
- `<Space>bn` - Next buffer
- `<Space>bp` - Previous buffer
- `<Space>bd` - Delete buffer

**Windows:**
- `<Space>ws` - Split horizontally
- `<Space>wv` - Split vertically
- `<Space>wq` - Close window

See [mappings.lua](.config/nvim/lua/mappings.lua) for complete list.

### Auto-formatting

Format-on-save enabled for: `.rs`, `.js`, `.jsx`, `.ts`, `.tsx`

Configure in [lsp/init.lua](.config/nvim/lua/lsp/init.lua)

## Installation

1. **Install Neovim 0.12+**
   ```bash
   # See: https://github.com/neovim/neovim/wiki/Installing-Neovim
   ```

2. **Install this configuration**
   ```bash
   # Clone this repository to your config location
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   
   # Use GNU Stow to symlink the Neovim configuration
   cd ~/.dotfiles
   stow nvim
   ```

3. **Install dependencies**
   - [JetBrains Mono Nerd Font](https://www.nerdfonts.com/) (for icons)
   - [ripgrep](https://github.com/BurntSushi/ripgrep) (for live grep)
   - [Node.js](https://nodejs.org/) (for many LSP servers)
   - [Rust](https://rustup.rs/) (for Rust development)

4. **Launch Neovim**
   ```bash
   nvim
   ```
   Plugins and LSP servers will be automatically installed via Mason.

## Customization

- **Theme**: Edit `vim.cmd 'colorscheme catppuccin'` in [ui.lua](.config/nvim/lua/ui.lua)
- **Keybindings**: Modify [mappings.lua](.config/nvim/lua/mappings.lua)
- **LSP servers**: Add/remove in [lsp-list.lua](.config/nvim/lua/lsp-list.lua)
- **Editor settings**: Adjust [settings.lua](.config/nvim/lua/settings.lua)

## Troubleshooting

- **LSP server issues**: Run `:Mason` to manage LSP servers
- **Performance issues**: Check for slow plugins with `:profile start`
- **Keybinding conflicts**: Use `:map` to list all keybindings
