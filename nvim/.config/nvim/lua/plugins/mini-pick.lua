return {
  'nvim-mini/mini.pick',
  opts = {},
  config = function()
    require('mini.pick').setup({
      source = {
        files = {
          command = { 'rg', '--files', '--hidden', '--glob', '--no-ignore' },
        },
      },
    })
  end,
  keys = {
    { '<leader>ff', '<cmd>Pick files<cr>', mode = 'n' },
    { '<leader>fg', '<cmd>Pick grep_live<cr>', mode = 'n' },
    { '<leader>fb', '<cmd>Pick buffers<cr>', mode = 'n' },
  }
}
