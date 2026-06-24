return {
  'folke/trouble.nvim' ,
  keys = {
    { '<leader>et', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle Trouble' } },
    { '<leader>es', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Toggle Trouble Symbols' } },
    { '<leader>el', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'Toggle Trouble LSP' } },
    { '<leader>eo', '<cmd>Trouble loclist toggle<cr>', { desc = 'Toggle Trouble Loclist' } },
    { '<leader>eq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Toggle Trouble Qflist' } },
  }
}
