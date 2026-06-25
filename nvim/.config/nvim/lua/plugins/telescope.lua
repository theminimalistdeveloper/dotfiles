return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
  },
  keys = {
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Find buffers' },
    { '<leader>fc', function() require('telescope.builtin').commits() end, desc = 'Find commits' },
    { '<leader>fd', function() require('telescope.builtin').diagnostics() end, desc = 'Find diagnostics' },
    { '<leader>ff', function() require('telescope.builtin').find_files({ hidden = true }) end, desc = 'Find files' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Find content with grep' },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Find help tags' },
    { '<leader>fm', function() require('telescope.builtin').marks() end, desc = 'Find marks' },
    { '<leader>fq', function() require('telescope.builtin').quickfix() end, desc = 'Find quickfix' },
    { '<leader>fp', function() require('telescope.builtin').find_files({ cwd = '~/.config/nvim/lua/' }) end, desc = 'Find Neovim configuration files' },
    { '<leader>fk', function() require('telescope.builtin').keymaps() end, desc = 'Find keymaps' },
    { '<leader>fz', function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = 'Fuzzy find in the current buffer' },
    { '<leader>fr', function() require('telescope.builtin').lsp_references() end, desc = 'Find all the references of this symbol' },
  }
}
