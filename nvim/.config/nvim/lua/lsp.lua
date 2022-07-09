--------------------------------------------------------------------------------
-- NATIVE LSP
--------------------------------------------------------------------------------

local lspconfig = require 'lspconfig'

local capabilities = require('cmp_nvim_lsp')
    .update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
  virtual_text = false,
  float = {
    -- To show only the diagnostics of the current cursor position
    scope = 'cursor',
    source = true,
  },
});

-- Run formatting before saving the buffer for js* ts* files
vim.api.nvim_command([[
  autocmd BufWritePre *.lua,*.rs,*.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.formatting_sync()
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
-- Language servers configuration
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
  javascript = { prettier },
  typescript = { prettier },
  javascriptreact = { eslint, prettier },
  typescriptreact = { eslint, prettier },
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
-- Mainly for signatures
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      hint_prefix = '',
      padding = ' ',
    }, bufnr)
  end
}

-- Rust
--------------------------------------------------------------------------------
-- RLS
lspconfig.rls.setup {}

-- Lua
--------------------------------------------------------------------------------
-- Sumneko
lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true)
      },
      telemetry = {
        enable = true,
      }
    }
  }
}
