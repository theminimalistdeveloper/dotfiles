vim.pack.add({'https://github.com/folke/trouble.nvim'})

vim.keymap.set('n', '<leader>tb', '<cmd>Trouble diagnostics toggle<cr>')
vim.keymap.set('n', '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>')
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>')
vim.keymap.set('n', '<leader>to', '<cmd>Trouble loclist toggle<cr>')
vim.keymap.set('n', '<leader>tq', '<cmd>Trouble qflist toggle<cr>')
