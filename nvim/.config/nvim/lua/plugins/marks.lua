return {
  'chentoast/marks.nvim',
  keys = {
    { '<leader>md', '<cmd>delmarks 0-9a-zA-Z<cr>', { desc = 'Delete all marks'} },
    { '<leader>mn', "]'", { desc = 'Go to the next mark'} },
    { '<leader>m0', "['", { desc = 'Go to the next mark'} },
  }
}
