vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    -- JS/TS debugger
    'https://github.com/mxsdev/nvim-dap-vscode-js',
    'https://github.com/microsoft/vscode-js-debug',
})

local dap = require('dap')
local dapui = require('dapui')

dap.set_log_level('TRACE')
-------------------------------------------------------------------------------
-- DAP UI
-------------------------------------------------------------------------------
dapui.setup()

require('nvim-dap-virtual-text').setup()

-- Automatically open/close DAP UI when debugging starts/ends
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

-------------------------------------------------------------------------------
-- SIGNS
-------------------------------------------------------------------------------
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '◐', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

-------------------------------------------------------------------------------
-- NODE / TYPESCRIPT (vscode-js-debug)
-------------------------------------------------------------------------------

local js_debugger = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = { js_debugger, '${port}'}
  }
}

dap.adapters["pwa-chrome"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { js_debugger, "${port}" },
  },
}

local js_configs = {'javascript', 'typescript', 'typescriptreact', 'javascriptreact'}
local configurations = {}

for _, v in ipairs(js_configs) do
  configurations[v] = {
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to app',
      address = 'localhost',
      port = 9229,
      cwd = '${workspaceFolder}',
      restart = true,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome",
      url = "https://localhost",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
    },
    {
      type = "pwa-chrome",
      request = "attach",
      name = "Attach to Chrome",
      port = 9222,
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
    },
  }
end

dap.configurations = configurations

-------------------------------------------------------------------------------
-- KEYMAPS
-------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dB', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Set conditional breakpoint' })
vim.keymap.set('n', '<leader>dl', function()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = 'Set log point' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step into' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step over' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step out' })
vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Open REPL' })
vim.keymap.set('n', '<leader>dR', dap.run_last, { desc = 'Run last' })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle DAP UI' })
vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = 'Terminate' })
vim.keymap.set({ 'n', 'v' }, '<leader>de', function()
    dapui.eval(nil, { enter = true })
end, { desc = 'Eval under cursor' })
