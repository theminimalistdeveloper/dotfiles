vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

-- In your /plugins/nvim-treesitter.lua
local configs = require('nvim-treesitter')

configs.setup({
    -- The 'ensure_installed' list still works in the new version
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
    -- Auto-install parsers when you open a new filetype
    auto_install = true,

    highlight = {
        enable = true, -- This is now the primary way to toggle TS highlighting
    },
})
