--- ----------------------------------------------------------------------------
-- NATIVE LSP
-------------------------------------------------------------------------------
---@diagnostic disable: undefined-global

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
})

-------------------------------------------------------------------------------
-- LANGUAGE SERVERS CONFIGURATION
-------------------------------------------------------------------------------

-- Typescript & Javascript
-------------------------------------------------------------------------------

lsp.config['eslint'] = {
  cmd = { 'eslint_d', '--stdio' },
  root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
}

lsp.config['vtsls'] = {
  cmd = { 'vtsls', '--stdio' },
  root_markers = { 'tsconfig.json', 'package.json' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
}

-- Rust
-------------------------------------------------------------------------------
lsp.config['rust-analyzer'] = {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml' },
  filetypes = { 'rust', 'rs' }
}

-- Lua
-------------------------------------------------------------------------------
lsp.config['luals'] = {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  filetypes = { 'lua' }
}

-- Tailwindcss
-------------------------------------------------------------------------------
vim.lsp.config['tailwindcss'] = {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.ts',
    'tailwind.config.tsx',
    'tailwind.config.json',
    'tailwind.config.mjs',
    'package.json' -- fallback for npm projects
  },
  filetypes = {
    'html',
    'css',
    'scss',
    'sass',
    'postcss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
    'jsx',
    'tsx'
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  }
}

-- Biome
--------------------------------------------------------------------------------
vim.lsp.config['biome'] = {
  cmd = {'biome'},
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }
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
  'dotenv-linter',
  'eslint',
  'graphql',
  'luals',
  'rust-analyzer',
  'tailwindcss',
  'vtsls',
})
