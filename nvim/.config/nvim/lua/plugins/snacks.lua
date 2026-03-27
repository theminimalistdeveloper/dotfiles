vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
    picker = {},
    word = {},
})

vim.keymap.set('n', '<leader>ff', function()
    Snacks.picker.files()
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>fg', function()
    Snacks.picker.grep()
end, { desc = 'Live grep' })

vim.keymap.set('n', '<leader>fb', function()
    Snacks.picker.buffers()
end, { desc = 'Find buffers' })
