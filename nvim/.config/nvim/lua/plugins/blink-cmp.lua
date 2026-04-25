vim.pack.add({
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp',
})

require('blink.cmp').setup({
    keymap = {
        preset = 'none',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    snippets = {
        preset = 'luasnip',
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
        list = {
            selection = { preselect = true, auto_insert = true },
        },
        menu = {
            auto_show = true,
        },
    },
})
