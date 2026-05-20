vim.pack.add({ 
    'https://github.com/nvim-lua/popup.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
})

require("telescope").setup()

vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Find content with grep' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Find help tags' })
vim.keymap.set('n', '<leader>fp', '<cmd>Telescope find_files cwd=~/.config/nvim/lua/<cr>', { desc = 'Find Neovim configuration files' })
