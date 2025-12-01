-- NATIVE LSP
--------------------------------------------------------------------------------

local lsp = vim.lsp

-- Run formatting before saving the buffer im.lsp.buf.formatting is deprecated.
-- Use vim.lsp.buf.format { async = true } instead
vim.api.nvim_command([[
    autocmd BufWritePre *.rs,*.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format()
]])

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

-------------------------------------------------------------------------------
-- LANGUAGE SERVERS CONFIGURATION
-------------------------------------------------------------------------------

local schemastore = require('schemastore')

local lsp_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/lsp/*.lua", true, true)

for _, file in ipairs(lsp_files) do
  local filename = vim.fn.fnamemodify(file, ":t:r") -- Get filename without extension
  if filename ~= "init" then -- Skip init.lua to avoid circular dependency
    require("lsp/" .. filename)
  end
end

lsp.enable(require('lsp-list'))
