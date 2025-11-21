-- NATIVE LSP
--------------------------------------------------------------------------------
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
  float = {
    border = 'rounded',
    source = 'always',
  },
})

lsp.handlers['textDocument/hover'] = lsp.with(
  lsp.handlers.hover,
  {
    title = ' Hover ',
    border = 'none',
    max_width = 100,
    max_height = 24,
    pad_top = 1,
    pad_bottom = 1,
    style = 'minimal',
    foscusable = false,
  }
)

lsp.handlers['textDocument/signatureHelp'] = lsp.with(
  lsp.handlers.signature_help,
  {
    title = ' Signature Help ',
    border = 'none',
    max_width = 100,
    max_height = 24,
    pad_top = 1,
    pad_bottom = 1,
    style = 'minimal',
    foscusable = false,
  }
)

-------------------------------------------------------------------------------
-- LANGUAGE SERVERS CONFIGURATION
-------------------------------------------------------------------------------
lsp.config['bashls'] = {}
lsp.config['biome'] = {}
lsp.config['cssls'] = {}
lsp.config['docker_compose_language_service'] = {}
lsp.config['dotenv-linter'] = {}
lsp.config['graphql'] = {}
lsp.config['html'] = {}
lsp.config['jsonls'] = {}
lsp.config['lua_ls'] = {}
lsp.config['luals'] = {}
lsp.config['rust_analyzer'] = {}
lsp.config['rust-analyzer'] = {}
lsp.config['tailwindcss'] = {
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
lsp.config['vtsls'] = {
  cmd = { 'vtsls', '--stdio' },
  root_markers = {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    '.git'
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue'
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}
lsp.config['yamlls'] = {}

lsp.enable({
  'bashls',
  'biome',
  'cssls',
  'docker_compose_language_service',
  'dotenv-linter',
  'graphql',
  'html',
  'jsonls',
  'lua_ls',
  'luals',
  'rust-analyzer',
  'rust_analyzer',
  'tailwindcss',
  'vtsls',
  'yamlls',
})
