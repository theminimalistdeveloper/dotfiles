vim.pack.add({ 'https://github.com/chentoast/marks.nvim'})

require('marks').setup()

vim.keymap.set('n', '<leader>md', '<cmd>delmarks 0-9a-zA-Z<cr>', { desc = 'Delete all marks'})
vim.keymap.set('n', '<leader>mn', "]'", { desc = 'Go to the next mark'})
vim.keymap.set('n', '<leader>mp', "['", { desc = 'Go to the previous mark'})
