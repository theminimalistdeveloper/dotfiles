return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    { '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', mode='n'},
    { '<leader>tb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', mode='n'},
    { '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', mode='n'},
    { '<leader>tl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', mode='n'},
    { '<leader>to', '<cmd>Trouble loclist toggle<cr>', mode='n'},
    { '<leader>tq', '<cmd>Trouble qflist toggle<cr>', mode='n'},
  }
}
