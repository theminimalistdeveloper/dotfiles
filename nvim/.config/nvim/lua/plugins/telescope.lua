vim.pack.add({
    'https://github.com/nvim-lua/popup.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
})

require("telescope").setup()
local telescope = require("telescope.builtin")

vim.keymap.set('n', '<leader>fb',
  function() telescope.buffers() end, { desc = 'Find buffers' })

vim.keymap.set('n', '<leader>fc',
  function() telescope.commits() end, { desc = 'Find commits' })

vim.keymap.set('n', '<leader>fd',
  function() telescope.diagnostics() end, { desc = 'Find diagnostics' })

vim.keymap.set('n', '<leader>ff',
  function() telescope.find_files({ hidden = true}) end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>fg',
  function() telescope.live_grep() end, { desc = 'Find content with grep' })

vim.keymap.set('n', '<leader>fh',
  function() telescope.help_tags() end, { desc = 'Find help tags' })

vim.keymap.set('n', '<leader>fm', function() telescope.marks() end, { desc = 'Find marks' })

vim.keymap.set('n', '<leader>fq', function() telescope.quickfix() end, { desc = 'Find quickfix' })

vim.keymap.set('n', '<leader>fp', function()
  telescope.find_files({ cwd = '~/.config/nvim/lua/' })
end, { desc = 'Find Neovim configuration files' })

vim.keymap.set('n', '<leader>fk', function() telescope.keymaps() end, { desc = 'Find keymaps' })

vim.keymap.set('n', '<leader>fz',
  function() telescope.current_buffer_fuzzy_find() end, { desc = 'Fuzzy find in the current buffer' })

vim.keymap.set('n', '<leader>fr',
  function() telescope.lsp_references() end, { desc = 'Find all the references of this symbol' })
