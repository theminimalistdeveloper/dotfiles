return {
  'mrcjkb/rustaceanvim',
  keys = {
    { '<leader>ur', '<cmd>RustLsp run<cr>', desc = 'Run Rust binary' },
    { '<leader>ud', '<cmd>RustLsp openDocs<cr>', desc = 'Open documentation' },
    { '<leader>ua', '<cmd>RustLsp hover actions<cr>', desc = 'Show hover actions' },
    { '<leader>un', '<cmd>RustLsp hover range<cr>', desc = 'Show hover range' },
    { '<leader>uu', '<cmd>RustLsp debbugables<cr>', desc = 'Show debuggable items' },
    { '<leader>ue', '<cmd>RustLsp expandMacro<cr>', desc = 'Expand macro' },
    { '<leader>uc', '<cmd>RustLsp codeAction<cr>', desc = 'Apply code action' },
    { '<leader>ux', '<cmd>RustLsp explainError current<cr>', desc = 'Explain current error' },
    { '<leader>umu', '<cmd>RustLsp moveItem up<cr>', desc = 'Move item up' },
    { '<leader>umd', '<cmd>RustLsp moveItem down<cr>', desc = 'Move item down' },
    { '<leader>ui', '<cmd>RustLsp renderDiagnostic<cr>', desc = 'Render diagnostic' },
    { '<leader>ut', '<cmd>RustLsp relatedTests<cr>', desc = 'Show related tests' },
    { '<leader>uo', '<cmd>RustLsp openCargo<cr>', desc = 'Open Cargo.toml' },
    { '<leader>uj', '<cmd>RustLsp joinLines<cr>', desc = 'Join lines' },
    { '<leader>ug', '<cmd>RustLsp crateGraph<cr>', desc = 'Show crate graph' },
    { '<leader>uvh', '<cmd>RustLsp view hir<cr>', desc = 'View HIR' },
    { '<leader>uvm', '<cmd>RustLsp view mir<cr>', desc = 'View MIR' },
  }
}
