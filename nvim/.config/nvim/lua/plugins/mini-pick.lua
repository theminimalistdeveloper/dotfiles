vim.pack.add({'https://github.com/nvim-mini/mini.pick'})

require('mini.pick').setup({
  source = {
    files = {
      command = { 'rg', '--files', '--hidden', '--glob', '--no-ignore' },
    },
  },
})

vim.keymap.set('v', '<leader>ff', '<cmd>Pick files<cr>' )
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<cr>')
