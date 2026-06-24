return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local configs = require('nvim-treesitter')

    configs.setup({
      ensure_installed = {
        'bash',
        'c',
        'css',
        'diff',
        'gitcommit',
        'gitignore',
        'go',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'norg',
        'php',
        'printf',
        'python',
        'query',
        'regex',
        'rust',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end
}
