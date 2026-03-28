vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
vim.pack.add({ 'https://github.com/nvim-telescope/telescope.nvim' })

local telescope = require('telescope')

telescope.setup({
    defaults = {
        prompt_prefix = '🔭 ',
        selection_caret = ' ',
        path_display = { 'smart' },
    },
})

local builtin = require('telescope.builtin')
 -- ...existing code...
local map = vim.keymap.set

-- default options used below
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files()
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep()
end, { desc = 'Live grep' })

vim.keymap.set('n', '<leader>fb', function()
    builtin.buffers()
end, { desc = 'Find buffers' })

-- Normal-mode mappings
map('n', '<leader>ff', require('telescope.builtin').find_files, vim.tbl_extend('force', opts, { desc = 'Telescope: Find files' }))
map('n', '<leader>fg', require('telescope.builtin').live_grep, vim.tbl_extend('force', opts, { desc = 'Telescope: Live grep' }))
map('n', '<leader>fb', require('telescope.builtin').buffers, vim.tbl_extend('force', opts, { desc = 'Telescope: Buffers' }))
map('n', '<leader>fh', require('telescope.builtin').help_tags, vim.tbl_extend('force', opts, { desc = 'Telescope: Help tags' }))
