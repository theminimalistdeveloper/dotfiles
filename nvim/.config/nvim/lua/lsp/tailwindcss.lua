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
