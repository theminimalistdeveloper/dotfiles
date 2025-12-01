vim.lsp.config['biome'] = {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'css',
    'vue',
    'astro',
    'svelte'
  },
  root_markers = {
    'biome.json',
    'biome.jsonc',
    'package.json',
    '.git'
  },
  single_file_support = true,
  settings = {
    biome = {
      -- Enable formatting
      formatter = {
        enabled = true,
        formatOnSave = true,
        indentStyle = "space",
        indentSize = 2,
        lineWidth = 80
      },
      -- Enable linting
      linter = {
        enabled = true,
        rules = {
          recommended = true
        }
      },
      -- Enable code actions
      codeAction = {
        enabled = true
      }
    }
  }
}
