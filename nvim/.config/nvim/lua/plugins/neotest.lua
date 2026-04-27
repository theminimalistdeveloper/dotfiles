vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/antoinemadec/FixCursorHold.nvim',
    'https://github.com/nvim-neotest/neotest',
    -- Test adapters
    'https://github.com/nvim-neotest/neotest-jest',
    'https://github.com/rouge8/neotest-rust',
})

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

vim.keymap.set('n', '<leader>tn', '<cmd>lua require("neotest").run.run()<cr>', { desc = 'Run nearest test' })
vim.keymap.set('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', { desc = 'Run current file tests' })
vim.keymap.set('n', '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', { desc = 'Toggle test summary' })
vim.keymap.set('n', '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', { desc = 'Show test output' })
vim.keymap.set('n', '<leader>tp', '<cmd>lua require("neotest").output_panel.toggle()<cr>', { desc = 'Toggle output panel' })
vim.keymap.set('n', '<leader>tl', '<cmd>lua require("neotest").run.run_last()<cr>', { desc = 'Run last test' })
vim.keymap.set('n', '<leader>td', '<cmd>lua require("neotest").run.run({ strategy = "dap" })<cr>', { desc = 'Debug nearest test' })

