vim.pack.add({ 'https://github.com/folke/trouble.nvim' })

require('trouble').setup()

vim.keymap.set('n', '<leader>et', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle Trouble' })
vim.keymap.set('n', '<leader>es', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Toggle Trouble Symbols' })
vim.keymap.set(
    'n',
    '<leader>el',
    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    { desc = 'Toggle Trouble LSP' }
)
vim.keymap.set('n', '<leader>eo', '<cmd>Trouble loclist toggle<cr>', { desc = 'Toggle Trouble Loclist' })
vim.keymap.set('n', '<leader>eq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Toggle Trouble Qflist' })
