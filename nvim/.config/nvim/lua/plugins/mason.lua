return {
  'https://github.com/williamboman/mason.nvim' ,
  config = function()
    require('mason').setup({ ensure_installed = require('../config.lsp-list') })
  end
}
