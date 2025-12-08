vim.pack.add({'https://github.com/williamboman/mason.nvim'})
require('mason').setup {
  ensure_installed = require('../lsp-list')
}
