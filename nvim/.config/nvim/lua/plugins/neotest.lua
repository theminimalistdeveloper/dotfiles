return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neotest/nvim-nio',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/neotest-jest',
    'rouge8/neotest-rust',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        -- JavaScript / TypeScript test adapter (Jest)
        require('neotest-jest')({
          jestCommand = 'npx jest',
          jestConfigFile = 'jest.config.ts',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        -- Rust test adapter (cargo test)
        require('neotest-rust')({
          args = { '--no-capture' },
        }),
      },
    })
  end,
  keys = {
    { '<leader>tn', '<cmd>lua require("neotest").run.run()<cr>', { desc = 'Run nearest test' } },
    { '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', { desc = 'Run current file tests' } },
    { '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', { desc = 'Toggle test summary' } },
    { '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', { desc = 'Show test output' } },
    { '<leader>tp', '<cmd>lua require("neotest").output_panel.toggle()<cr>', { desc = 'Toggle output panel' } },
    { '<leader>tl', '<cmd>lua require("neotest").run.run_last()<cr>', { desc = 'Run last test' } },
    { '<leader>td', '<cmd>lua require("neotest").run.run({ strategy = "dap" })<cr>', { desc = 'Debug nearest test' } },
  }
}
