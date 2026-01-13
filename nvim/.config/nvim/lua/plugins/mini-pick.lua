vim.pack.add({'https://github.com/nvim-mini/mini.pick'})

require('mini.pick').setup()

vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', { desc='Find files'})
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc='Live grep'})
vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<cr>', { desc='Find buffers'})
