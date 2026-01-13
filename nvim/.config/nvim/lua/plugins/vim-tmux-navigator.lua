vim.pack.add({'https://github.com/christoomey/vim-tmux-navigator'})

vim.keymap.set('n', '<c-j>', '<cmd>TmuxNavigateDown<cr>', { desc='Navigate to tmux pane below' })
vim.keymap.set('n', '<c-k>', '<cmd>TmuxNavigateUp<cr>', { desc='Navigate to tmux pane above' })
vim.keymap.set('n', '<c-l>', '<cmd>TmuxNavigateRight<cr>', { desc='Navigate to tmux pane right' })
vim.keymap.set('n', '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc='Navigate to previous tmux pane' })
