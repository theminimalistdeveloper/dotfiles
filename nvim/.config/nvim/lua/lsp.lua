-------------------------------------------------------------------------------
-- NATIVE LSP
-------------------------------------------------------------------------------

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

vim.lsp.config['eslint'] = {
  cmd = { 'eslint', '--stdio' },
  root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
}

vim.lsp.config['vtsls'] = {
  cmd = { 'vtsls', '--stdio' },
  root_markers = { 'tsconfig.json', 'package.json' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
}

-- Rust
-------------------------------------------------------------------------------
vim.lsp.config['rust-analyzer']= {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml' },
  filetypes = { 'rust' }
}

-- Lua
-------------------------------------------------------------------------------
vim.lsp.config['luals'] = {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  filetypes = { 'lua' }
}

-- Tailwindcss
-------------------------------------------------------------------------------
vim.lsp.config['tailwindcss'] = {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'tailwind.config.tsx', 'tailwind.config.json' },
  filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
}

-- Bash
-------------------------------------------------------------------------------
vim.lsp.config['bashls'] = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' }
}

-- Graphql
-------------------------------------------------------------------------------
vim.lsp.config['graphql'] = {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql' }
}

vim.lsp.enable({
  'bashls',
  'eslint',
  'graphql',
  'luals',
  'rust_analyzer',
  'tailwindcss',
  'vtsls',
})
