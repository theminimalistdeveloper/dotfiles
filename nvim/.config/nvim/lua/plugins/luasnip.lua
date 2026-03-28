vim.pack.add({
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/rafamadriz/friendly-snippets',
})

require('luasnip').setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

-- Load VSCode-style snippets (friendly-snippets) lazily
require("luasnip.loaders.from_vscode").lazy_load()
