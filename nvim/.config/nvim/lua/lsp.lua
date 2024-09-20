----------------------------------------------------------------------------
-- NATIVE LSP
--------------------------------------------------------------------------------

local lspconfig = require 'lspconfig'
local signs = require 'signs'

-- Set diagnostic signs
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- General configuration
vim.diagnostic.config({
  update_in_insert = true,
  signs = true,
  underline = true,
  virtual_text = true,
  float = {
    -- To show only the diagnostics of the current cursor position
    scope = 'cursor',
    source = true,
  },
})

-- Run formatting before saving the buffer im.lsp.buf.formatting is deprecated. Use vim.lsp.buf.format { async = true } instead
vim.api.nvim_command([[
    autocmd BufWritePre *.lua,*.rs,*.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format()
]])

-- Enable showing the diagnostic of the current cursor position
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor', border='rounded'})]]

-- Add rounded corners to signature and to the hover window
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
);

--------------------------------------------------------------------------------
-- LANGUAGE SERVERS CONFIGURATION
--------------------------------------------------------------------------------

-- Typescript & Javascript
--------------------------------------------------------------------------------

local eslint = {
  lintCommand = "rslint -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
}

local prettier = {
  formatCommand = 'prettier --config "$(prettier --find-config-path ./src)" --stdin-filepath ${INPUT}',
  formatStdin = true
}

-- EFM
local efm_languages = {
  yaml = { prettier },
  json = { prettier },
  html = { prettier },
  scss = { prettier },
  css = { prettier },
  markdown = { prettier },
};

-- Prettier format and ESLint information
lspconfig.efm.setup {
  init_options = {
    documentFormatting = true,
    hover = false,
    documentSymbol = false,
    codeAction = false,
    completion = false,
  },
  settings = {
    rootMarkers = { '.git/', 'package.json' },
    languages = efm_languages,
  },
  filetypes = vim.tbl_keys(efm_languages),
}


-- TSServer
--------------------------------------------------------------------------------
lspconfig.ts_ls.setup {}

-- Rust
--------------------------------------------------------------------------------
lspconfig.rust_analyzer.setup {}

-- Lua
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
lspconfig.tailwindcss.setup {}

-- LanguageTool
--------------------------------------------------------------------------------
lspconfig.ltex.setup {}
