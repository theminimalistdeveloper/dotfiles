vim.pack.add({'https://github.com/folke/trouble.nvim'})

require("trouble").setup()

vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', { desc='Toggle Trouble' })
vim.keymap.set('n', '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', { desc='Toggle Trouble Symbols' })
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc='Toggle Trouble LSP' })
vim.keymap.set('n', '<leader>to', '<cmd>Trouble loclist toggle<cr>', { desc='Toggle Trouble Loclist' })
vim.keymap.set('n', '<leader>tq', '<cmd>Trouble qflist toggle<cr>', { desc='Toggle Trouble Qflist' })
