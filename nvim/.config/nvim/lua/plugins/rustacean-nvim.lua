vim.pack.add({
    'https://github.com/mrcjkb/rustaceanvim',
})

-- vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true

-- RUST $U
vim.keymap.set('n', '<leader>ur', '<cmd>RustLsp run<cr>')
vim.keymap.set('n', '<leader>ud', '<cmd>RustLsp openDocs<cr>')
vim.keymap.set('n', '<leader>ua', '<cmd>RustLsp hover actions<cr>')
vim.keymap.set('n', '<leader>un', '<cmd>RustLsp hover range<cr>')
vim.keymap.set('n', '<leader>uu', '<cmd>RustLsp debbugables<cr>')
vim.keymap.set('n', '<leader>ue', '<cmd>RustLsp expandMacro<cr>')
vim.keymap.set('n', '<leader>uc', '<cmd>RustLsp codeAction<cr>')
vim.keymap.set('n', '<leader>ux', '<cmd>RustLsp explainError current<cr>')
vim.keymap.set('n', '<leader>umu', '<cmd>RustLsp moveItem up<cr>')
vim.keymap.set('n', '<leader>umd', '<cmd>RustLsp moveItem down<cr>')
vim.keymap.set('n', '<leader>ui', '<cmd>RustLsp renderDiagnostic<cr>')
vim.keymap.set('n', '<leader>ut', '<cmd>RustLsp relatedTests<cr>')
vim.keymap.set('n', '<leader>uo', '<cmd>RustLsp openCargo<cr>')
vim.keymap.set('n', '<leader>uj', '<cmd>RustLsp joinLines<cr>')
vim.keymap.set('n', '<leader>ug', '<cmd>RustLsp crateGraph<cr>')
vim.keymap.set('n', '<leader>uvh', '<cmd>RustLsp view hir<cr>')
vim.keymap.set('n', '<leader>uvm', '<cmd>RustLsp view mir<cr>')
