return {
  'christoomey/vim-tmux-navigator' ,
  lazy = false,
  keys = {
    { '<c-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate to tmux pane below' } },
    { '<c-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate to tmux pane above' } },
    { '<c-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate to tmux pane right' } },
    { '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Navigate to previous tmux pane' } },
  }
}
