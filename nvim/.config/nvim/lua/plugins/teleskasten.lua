vim.pack.add({
    'https://github.com/nvim-telekasten/calendar-vim',
    'https://github.com/nvim-telekasten/telekasten.nvim',
})

local tk = require('telekasten')

tk.setup({ home = vim.fn.expand('~/CloudDrive') })

vim.keymap.set('n', '<leader>kf', tk.find_notes, { desc = 'Find notes' })
vim.keymap.set('n', '<leader>kg', tk.search_notes, { desc = 'Search notes (grep)' })
vim.keymap.set('n', '<leader>kd', tk.goto_today, { desc = 'Go to today (daily)' })
vim.keymap.set('n', '<leader>kw', tk.goto_thisweek, { desc = 'Go to this week' })
vim.keymap.set('n', '<leader>kn', tk.new_note, { desc = 'New note' })
vim.keymap.set('n', '<leader>kN', tk.new_templated_note, { desc = 'New templated note' })
vim.keymap.set('n', '<leader>kl', tk.follow_link, { desc = 'Follow link' })
vim.keymap.set('n', '<leader>ky', tk.yank_notelink, { desc = 'Yank note link' })
vim.keymap.set('n', '<leader>kb', tk.show_backlinks, { desc = 'Show backlinks' })
vim.keymap.set('n', '<leader>kF', tk.find_friends, { desc = 'Find friends' })
vim.keymap.set('n', '<leader>ki', tk.insert_link, { desc = 'Insert link' })
vim.keymap.set('n', '<leader>kI', tk.insert_img_link, { desc = 'Insert image link' })
vim.keymap.set('n', '<leader>kp', tk.preview_img, { desc = 'Preview image' })
vim.keymap.set('n', '<leader>kt', tk.toggle_todo, { desc = 'Toggle todo' })
vim.keymap.set('n', '<leader>kT', tk.show_tags, { desc = 'Show tags' })
vim.keymap.set('n', '<leader>kr', tk.rename_note, { desc = 'Rename note' })
vim.keymap.set('n', '<leader>kc', tk.show_calendar, { desc = 'Show calendar' })
vim.keymap.set('n', '<leader>kk', tk.panel, { desc = 'Telekasten panel' })
