return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/neotest-jest',
    'rouge8/neotest-rust',
  },
  config = function()
    require('neotest').setup({})
  end,
  keys = {
    -- Test the nearest test from the current position
    { '<leader>en', '<cmd>lua require("neotest").run.run()<cr>', mode='n' },
    -- Test the current file
    {
      '<leader>ef',
      '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>',
      mode='n'
    },
    -- Test the last test done
    {'<leader>el', '<cmd>lua require("neotest").run.run_last()<cr>'},
    -- Open the output panel
    {
      '<leader>ep',
      '<cmd>lua require("neotest").output.open({ enter=true, auto_close=true })<cr>',
      mode='n'
    },
    -- Clear output panel
    {'<leader>epc', '<cmd>lua require("neotest").output.clear()<cr>', mode='n' },
    -- Toggle summary panel
    {'<leader>es', '<cmd>lua require("neotest").summary.toggle()<cr>', mode='n' },
    -- Run DAP
    {
      '<leader>ed',
      '<cmd>lua require("neotest").run.run({ strategy="dap" })<cr>',
      mode='n'
    },
  },
}
