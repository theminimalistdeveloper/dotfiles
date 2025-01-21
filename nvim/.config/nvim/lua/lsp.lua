-------------------------------------------------------------------------------
-- NATIVE LSP
-------------------------------------------------------------------------------

local lspconfig = require 'lspconfig'

-- Run formatting before saving the buffer im.lsp.buf.formatting is deprecated.
-- Use vim.lsp.buf.format { async = true } instead
vim.api.nvim_command([[
    autocmd BufWritePre *.rs,*.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format()
]])

-------------------------------------------------------------------------------
-- LANGUAGE SERVERS CONFIGURATION
-------------------------------------------------------------------------------

-- Typescript & Javascript
-------------------------------------------------------------------------------

lspconfig.eslint.setup {}
lspconfig.ts_ls.setup {}

-- Rust
-------------------------------------------------------------------------------
lspconfig.rust_analyzer.setup {}

-- Lua
-------------------------------------------------------------------------------
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- Tailwindcss
-------------------------------------------------------------------------------
lspconfig.tailwindcss.setup {}

-- Latex
-------------------------------------------------------------------------------
lspconfig.ltex.setup {}
